class LactationsController < ApplicationController
  # GET /lactations
  # GET /lactations.json
  def index
    @lactations = Lactation.all
    @cows = Cow.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @lactations }
    end
  end

  # GET /lactations/1
  # GET /lactations/1.json
  def show
    @lactation = Lactation.find_by_sql('select * from Lactations where cow_id = '+params[:id])
    if @lactation.nil?
      @lactation = []
    elsif @lactation.instance_of? Lactation 
      p '----------------------------------Lactation'
      @aux = @lactation
      @lactation = []
      @lactation[0]= @aux
    elsif @lactation.instance_of? Array
      p '----------------------____Array'
    elsif @lactation.length

    end
    @cow = Cow.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @lactation }
    end
  end

  # GET /lactations/new
  # GET /lactations/new.json
  def new
    @lactation = Lactation.new
    @cow_id = params[:cow_id]
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @lactation }
    end
  end

  # GET /lactations/1/edit
  def edit
    @lactation = Lactation.find(params[:id])
  end

  # POST /lactations
  # POST /lactations.json
  def create
    @lactation = Lactation.new(params[:lactation])

    respond_to do |format|
      if @lactation.save
        redirect_to lactation_path(8)
      else
        redirect_to lactation_path(params[:lactation][:cow_id])
      end
    end
  end

  # PUT /lactations/1
  # PUT /lactations/1.json
  def update
    @lactation = Lactation.find(params[:id])

    respond_to do |format|
      if @lactation.update_attributes(params[:lactation])
        format.html { redirect_to @lactation, notice: 'Lactation was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @lactation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lactations/1
  # DELETE /lactations/1.json
  def destroy
    @lactation = Lactation.find(params[:id])
    @lactation.destroy

    respond_to do |format|
      format.html { redirect_to lactations_url }
      format.json { head :no_content }
    end
  end
end
