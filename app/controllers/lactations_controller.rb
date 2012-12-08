class LactationsController < ApplicationController
  # GET /lactations
  # GET /lactations.json
  def index
    @cows = Cow.where('is_active=1')

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

    @start_month_date = Time.new.year.to_s+'-'+@month.to_s+'-01'
    @end_month_date = Time.new.year.to_s+'-'+@month.to_s+'-31'

    @lactation = Lactation.find(:all, :conditions=>["cow_id = ? and date between ? and ? ",params[:id],@start_month_date,@end_month_date])
    if @lactation.nil?
      @lactation = []
    elsif @lactation.instance_of? Lactation 
      @aux = @lactation
      @lactation = []
      @lactation[0]= @aux

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
      redirect_to lactation_path(params[:lactation][:cow_id])
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
