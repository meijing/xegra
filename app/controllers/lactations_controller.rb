class LactationsController < ApplicationController
  # GET /lactations
  # GET /lactations.json
  def index
    @cows = Cow.order('short_ring').is_active

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /lactations/1
  # GET /lactations/1.json
  def show
    if params[:month].nil?
      @month = DateTime.now.month
    else
      @month = params[:month]
    end

    @cow = Cow.find(params[:id])
    @lactations = @cow.lactations.for_month @month
    
    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /lactations/new
  # GET /lactations/new.json
  def new
    @lactation = Lactation.new
    @cow_id = params[:cow_id]
    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /lactations/1/edit
  def edit
    @cow_id = Cow.find(params[:cow_id]).id
    @lactation = Lactation.find(params[:id])
  end

  # POST /lactations
  # POST /lactations.json
  def create
    @lactation = Lactation.new(params[:lactation])
    @lactation.year = Time.now.year

    if @lactation.save
      redirect_to lactation_path(:id=>params[:lactation][:cow_id],:month=>@lactation.date.month)
    else
      redirect_to create_new_lactation_path(params[:lactation][:cow_id])
    end
    
  end

  # PUT /lactations/1
  # PUT /lactations/1.json
  def update
    @lactation = Lactation.find(params[:id])
    params[:lactation][:date] = Date.strptime(params[:lactation][:date], "%d-%m-%Y")

    if @lactation.update_attributes(params[:lactation])
      redirect_to lactation_path(params[:lactation][:cow_id])
    else
      redirect_to create_new_lactation_path(params[:lactation][:cow_id])
    end
  end

  # DELETE /lactations/1
  # DELETE /lactations/1.json
  def destroy
    @lactation = Lactation.find(params[:id])
    @lactation.destroy

    respond_to do |format|
      format.html { redirect_to lactation_path(@lactation.cow_id) }
      format.json { head :no_content }
    end
  end
end
