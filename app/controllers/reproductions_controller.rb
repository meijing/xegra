class ReproductionsController < ApplicationController
  # GET /reproductions
  # GET /reproductions.json
  def index
    p'-----------------------------------------'
    @reproductions = Reproduction.find_by_sql('select * from reproductions
      where year = 2012 order by cow_id, month')
    p @reproductions
    if @reproductions.nil?
      @reproductions = []
    end
p @reproductions
    #@cows = Cow.find_by_is_active(true)
    @cows = Cow.all

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
    @new_reproduction.year = Date.new.year
    @simbolId = params[:reproduction][:reproduction_simbol].split(' ')

    if (@simbolId[0] != 'Ningun')
      @simbol = ReproductionSimbol.find_by_simbol(@simbolId)
      @new_reproduction.reproduction_simbol_id = @simbol.id
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
    else
      @repro = ReproductionSimbol.find_by_id(@simbol_id)
      @repro_selected=@repro.simbol + " "+ @repro.meaning
    end
   
    if !params[:repro_id].nil? and params[:repro_id] =='-1'
      @reproduction = Reproduction.new
      @reproduction.month =  p params[:month]
      @is_add_enabled = false
    elsif !params[:repro_id].nil? and params[:repro_id] !='-1'
      @reproduction = Reproduction.find_by_id(params[:repro_id])
      @comment = @reproduction.comment
      @is_add_enabled = false
    elsif params[:repro_id].nil?
      @reproduction = Reproduction.new
      @reproduction.month =  p params[:month]
      @is_add_enabled = true
    end
    
  end
end
