class ReproductionsController < ApplicationController
  # GET /reproductions
  # GET /reproductions.json
  def index
    @reproductions = Reproduction.find_by_sql('select * from reproductions
      where year = 2012 order by cow_id, month')
    if @reproductions.nil?
      @reproductions = []
    end

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
    @reproduction = Reproduction.new(params[:reproduction])

    respond_to do |format|
      if @reproduction.save
        format.html { redirect_to @reproduction, notice: 'Reproduction was successfully created.' }
        format.json { render json: @reproduction, status: :created, location: @reproduction }
      else
        format.html { render action: "new" }
        format.json { render json: @reproduction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /reproductions/1
  # PUT /reproductions/1.json
  def update
    @reproduction = Reproduction.find(params[:id])

    respond_to do |format|
      if @reproduction.update_attributes(params[:reproduction])
        format.html { redirect_to @reproduction, notice: 'Reproduction was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @reproduction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reproductions/1
  # DELETE /reproductions/1.json
  def destroy
    @reproduction = Reproduction.find(params[:id])
    @reproduction.destroy

    respond_to do |format|
      format.html { redirect_to reproductions_url }
      format.json { head :no_content }
    end
  end

  def single_reproduction
    @cow = Cow.find_by_id(params[:id])
    @reproductions = Reproduction.find_by_sql('select * from reproductions where cow_id = '+params[:id])
    @repro_id = params[:repro_id]
    if @repro_id.nil?
      @repro_selected="Ningun"
    else
      @repro = ReproductionSimbol.find_by_id(@repro_id)
      @repro_selected=@repro.simbol + " "+ @repro.meaning
      @comment = Reproduction.find_by_id(@repro_id).comment
    end

  end
end
