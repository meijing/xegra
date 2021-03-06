# encoding: utf-8
class ReproductionsController < ApplicationController
  # GET /reproductions
  # GET /reproductions.json
  def index
    
    if (params[:year].nil? || (!params[:year].nil? && params[:year].to_i == DateTime.now.year))
      @year_btn = (DateTime.now.year-1).to_s
      @year = DateTime.now.year.to_s
      @reproductions = current_user.reproduction.actual_year.order('month')
    else
      @year_btn = DateTime.now.year.to_s
      @year = (DateTime.now.year-1).to_s
      @reproductions = current_user.reproduction.last_year.order('month')
    end

    if @reproductions.nil?
      @reproductions = []
    end

    @cows = current_user.cow.order('short_ring').is_active
  end

  # GET /reproductions/1
  # GET /reproductions/1.json
  def show
    @reproduction = current_user.reproduction.find(params[:id])
  end

  # GET /reproductions/new
  # GET /reproductions/new.json
  def new
    @reproductions = current_user.reproduction.find_by_cow_id(params[:id])
  end

  # GET /reproductions/1/edit
  def edit
    @reproduction = current_user.reproduction.find(params[:id])
  end

  # POST /reproductions
  # POST /reproductions.json
  def create
    @new_reproduction = Reproduction.new
    @new_reproduction.cow_id = params[:reproduction][:cow_id]
    @new_reproduction.month = params[:reproduction][:month]
    @new_reproduction.comment = params[:reproduction][:comment]
    
    @new_reproduction.user_id = current_user.id
    @simbolId = params[:reproduction][:reproduction_simbol].split(' ')
    if !params[:reproduction][:date].nil? && params[:reproduction][:date] !=""
      @new_reproduction.date = params[:reproduction][:date]
      @new_reproduction.year = @new_reproduction.date.year
    else
      @new_reproduction.year = params[:reproduction][:year]
    end

    if (@simbolId[0] != t('reproductions.no_simbol'))
      @simbol = ReproductionSimbol.find_by_simbol(@simbolId)
      @new_reproduction.reproduction_simbol_id = @simbol.id
      if (@simbolId[0] == '▲' || @simbolId[0] == '♀' || @simbolId[0] == '♂' || @simbolId[0] == '●')
        if @simbolId[0] == '♀' || @simbolId[0] == '♂' || (@simbolId[0] == '●' && @simbolId[1] == t('reproductions.dist_born'))
          @new_reproduction.cow.set_is_milk(true)
          @new_reproduction.cow.increment_num_borns
        elsif @simbolId[0] == '●' && @simbolId[1] == t('reproductions.abortion')
          @new_reproduction.cow.set_is_milk(true)
        end
        @new_reproduction.cow.set_is_pregnant(0)
        @new_reproduction.bull = params[:reproduction][:bull]
      end
    end
    @new_reproduction.save

    redirect_to proba_path(:id=>params[:reproduction][:cow_id],:year=>@new_reproduction.year)
    #redirect_to proba_repro_path(:id=>@new_reproduction.cow_id,:repro_id=>@new_reproduction.id,:simbol_id=>@new_reproduction.reproduction_simbol_id,:month=>@new_reproduction.month)
  end

  # PUT /reproductions/1
  # PUT /reproductions/1.json
  def update
    @reproduction = current_user.reproduction.find_by_id(params[:reproduction][:idReproduccion])
    @simbolId = params[:reproduction][:reproduction_simbol].split(' ')

    if (@simbolId[0] != t('reproductions.no_simbol'))
      @simbol = ReproductionSimbol.find_by_simbol(@simbolId)
      @reproduction.reproduction_simbol_id = @simbol.id
      if (@simbolId[0] == '▲' || @simbolId[0] == '♀' || @simbolId[0] == '♂' || @simbolId[0] == '●')
        if @simbolId[0] == '♀' || @simbolId[0] == '♂' || (@simbolId[0] == '●' && @simbolId[1] == t('reproductions.dist_born'))
          @reproduction.cow.set_is_milk(true)
          @reproduction.cow.increment_num_borns
        elsif @simbolId[0] == '●' && @simbolId[1] == t('reproductions.abortion')
          @reproduction.cow.set_is_milk(true)
        end
        @reproduction.cow.set_is_pregnant(0)
        @reproduction.bull = params[:reproduction][:bull]
      else
        @reproduction.bull = nil
        @reproduction.date = nil
      end
    else
      @reproduction.reproduction_simbol_id = nil
    end
    @reproduction.comment = params[:reproduction][:comment]
    if !params[:reproduction][:date].nil? && params[:reproduction][:date] !=""
      @reproduction.date = params[:reproduction][:date]
      @reproduction.year = @reproduction.date.year
    end
    
    @reproduction.save
    redirect_to proba_path(:id=>@reproduction.cow_id,:year=>@reproduction.year)
    
  end

  # DELETE /reproductions/1
  # DELETE /reproductions/1.json
  def destroy
    @reproduction = current_user.reproduction.find(params[:id])
    if @reproduction.reproduction_simbol_id == 1 || @reproduction.reproduction_simbol_id == 2
      @reproduction.check_is_pregnant(current_user)
      @reproduction.cow.decrement_num_borns
    end
    @reproduction.destroy

    redirect_to proba_path(@reproduction.cow_id)
  end

  def single_reproduction
    @cow = current_user.cow.find_by_id(params[:id])

    if (params[:year].nil? || (!params[:year].nil? && params[:year].to_i == DateTime.now.year))
      @reproductions = current_user.reproduction.actual_year.order('month').where('cow_id = '+params[:id])
      @year = @year = DateTime.now.year
    else
      @reproductions = current_user.reproduction.last_year.order('month').where('cow_id = '+params[:id])
      @year = @year = DateTime.now.year-1
    end

    @info_repro = Array.new(12, [])
    
    @reproductions.each do |r|
      if @info_repro[r.month-1] == []
        @info_repro[r.month-1] = [r]
      else
        @info_repro[r.month-1] << r
      end
    end
    
    @simbol_id = params[:simbol_id]
    if @simbol_id.nil? or @simbol_id =='-1'
      @repro_selected=t('reproductions.no_simbol')
      @is_bull_enabled=true
    else
      @repro = ReproductionSimbol.find_by_id(@simbol_id)
      @repro_selected=@repro.simbol + " "+ @repro.meaning
      if (@repro.simbol == '▲' )
        @is_bull_enabled = false
      else
        @is_bull_enabled = true
      end
      if @repro.simbol == '♀' || @repro.simbol == '♂'
        @cow.set_is_pregnant(nil)
      end
    end
   
    if !params[:repro_id].nil? and params[:repro_id] =='-1'
      @reproduction = Reproduction.new
      @reproduction.month =  params[:month]
      @is_add_enabled = false
    elsif !params[:repro_id].nil? and params[:repro_id] !='-1'
      @reproduction = current_user.reproduction.find_by_id(params[:repro_id])
      @comment = @reproduction.comment
      @bull = @reproduction.bull
      @date = @reproduction.date
      @is_add_enabled = false
    elsif params[:repro_id].nil?
      @reproduction = Reproduction.new
      @reproduction.month =  params[:month]
      @is_add_enabled = true
    end
    
  end

  private

  def get_simbol_reproduction(reproductions, cow_id)
    @info_repro = Array.new(12, [])
    reproductions.each do |r|
      if (r.cow_id == cow_id)
        @content = ""
        if (r.reproduction_simbol_id.nil?)
          @content = @content.concat(r.comment)
        else
          @content = @content + ReproductionSimbol.find_by_id(r.reproduction_simbol_id).simbol.concat(" "+r.comment)+'<br/>'
          if (!r.bull.nil?)
            @content = @content +'<br/>'+r.bull
          end
          if (!r.date.nil?)
            @content = @content + '<br/>'+ r.date.strftime('%d/%m/%Y')
          end
        end

        if @info_repro[r.month-1] == []
          @info_repro[r.month-1] = [@content.html_safe]
        else
          @info_repro[r.month-1] << @content.html_safe
        end
      end
    end
    return @info_repro
  end
end
