class LactationsController < ApplicationController
  # GET /lactations
  # GET /lactations.json
  def index
    @cows = current_user.cow.order('short_ring').is_active
  end

  # GET /lactations/1
  # GET /lactations/1.json
  def show
    if params[:month].nil?
      @month = DateTime.now.month
    else
      @month = params[:month]
    end

    @cow = current_user.cow.find(params[:id])
    @lactations = @cow.lactations.for_month @month
  end

  # GET /lactations/new
  # GET /lactations/new.json
  def new
    @lactation = Lactation.new
    @cow_id = params[:cow_id]
  end

  # GET /lactations/1/edit
  def edit
    @cow_id = current_user.cow.find(params[:cow_id]).id
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
    @lactation.date = @lactation.date.strftime('%d/%m/%Y')

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
  end
end
