# encoding: utf-8
class ReproductionsController < ApplicationController
  # GET /reproductions
  # GET /reproductions.json
  def index
    @reproductions = Reproduction.find_by_sql('select * from reproductions
      where year ='+Time.new.year.to_s+' order by cow_id, month')

    if @reproductions.nil?
      @reproductions = []
    end

    @cows = Cow.order('short_ring').is_active

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @reproductions }
    end
  end

  # GET /reproductions/1
  # GET /reproductions/1.json
  def show
    @reproduction = Reproduction.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @reproduction }
    end
  end

  # GET /reproductions/new
  # GET /reproductions/new.json
  def new
    @reproductions = Reproduction.find_by_cow_id(params[:id])

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /reproductions/1/edit
  def edit
    @reproduction = Reproduction.find(params[:id])
  end

  # POST /reproductions
  # POST /reproductions.json
  def create
    @new_reproduction = Reproduction.new
    @new_reproduction.cow_id = params[:reproduction][:cow_id]
    @new_reproduction.month = params[:reproduction][:repro_month]
    @new_reproduction.comment = params[:reproduction][:comment]
    @new_reproduction.year = DateTime.now.year
    @simbolId = params[:reproduction][:reproduction_simbol].split(' ')

    if (@simbolId[0] != 'Ningun')
      @simbol = ReproductionSimbol.find_by_simbol(@simbolId)
      @new_reproduction.reproduction_simbol_id = @simbol.id
      if (@simbolId[0] == '▲' || @simbolId[0] == '♀' || @simbolId[0] == '♂')
        @new_reproduction.bull = params[:reproduction][:bull]
        if !params[:reproduction][:date].nil? && params[:reproduction][:date] !=""
          @new_reproduction.date = params[:reproduction][:date]
        end
      end
    end
    @new_reproduction.save

    
    
    redirect_to proba_path(params[:reproduction][:cow_id])
  end

  # PUT /reproductions/1
  # PUT /reproductions/1.json
  def update
    @reproduction = Reproduction.find_by_id(params[:reproduction][:idReproduccion])
    @simbolId = params[:reproduction][:reproduction_simbol].split(' ')

    if (@simbolId[0] != 'Ningun')
      @simbol = ReproductionSimbol.find_by_simbol(@simbolId)
      @reproduction.reproduction_simbol_id = @simbol.id
      if (@simbolId[0] == '▲' || @simbolId[0] == '♀' || @simbolId[0] == '♂')
        @reproduction.bull = params[:reproduction][:bull]
        if !params[:reproduction][:date].nil? && params[:reproduction][:date] !=""
          @reproduction.date = params[:reproduction][:date]
        end
      else
        @reproduction.bull = nil
        @reproduction.date = nil
      end
    else
      @reproduction.reproduction_simbol_id = nil
    end
    @reproduction.comment = params[:reproduction][:comment]
    
    
    @reproduction.save
    redirect_to proba_path(@reproduction.cow_id)

  end

  # DELETE /reproductions/1
  # DELETE /reproductions/1.json
  def destroy
    @reproduction = Reproduction.find(params[:id])
    @reproduction.destroy

    redirect_to proba_path(@reproduction.cow_id)
  end

  def single_reproduction
    @cow = Cow.find_by_id(params[:id])

    @info_repro = Array.new(12, Hash.new)
    @reproductions = Reproduction.find_by_sql('select * from reproductions where cow_id = '+params[:id]+' order by month')
    @reproductions.each do |r|
      @info_repro[r.month-1] =r
    end

    @cont=0
    @info_repro.each do |r|
      if (r == {})
        @info_repro[@cont]=Reproduction.new
        @info_repro[@cont].month = @cont+1
        @cont +=1
      else
        @info_repro[@cont]=r
        @cont +=1
      end
    end
    
    @simbol_id = params[:simbol_id]
    
    if @simbol_id.nil? or @simbol_id =='-1'
      @repro_selected="Ningun"
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
        @cow.is_pregnant = nil
        @cow.save
      end
    end
   
    if !params[:repro_id].nil? and params[:repro_id] =='-1'
      @reproduction = Reproduction.new
      @reproduction.month =  p params[:month]
      @is_add_enabled = false
    elsif !params[:repro_id].nil? and params[:repro_id] !='-1'
      @reproduction = Reproduction.find_by_id(params[:repro_id])
      @comment = @reproduction.comment
      @bull = @reproduction.bull
      @date = @reproduction.date
      @is_add_enabled = false
    elsif params[:repro_id].nil?
      @reproduction = Reproduction.new
      @reproduction.month =  p params[:month]
      @is_add_enabled = true
    end
    
  end
end
