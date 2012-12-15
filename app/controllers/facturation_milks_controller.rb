class FacturationMilksController < ApplicationController
  # GET /facturation_milks
  # GET /facturation_milks.json
  def index

    @month = params[:month]
    @month_to_rest = DateTime.now.month - @month.to_i
    @start_date = DateTime.now.ago(@month_to_rest.months).beginning_of_month
    @end_date = DateTime.now.ago(@month_to_rest.months).end_of_month

    @facturation_milks = FacturationMilk.find(:all, :conditions=>["date between ? and ? ",@start_date,@end_date])

    @last_day = @end_date.day
    
    @liters = get_liters_for_month(@month)
    @total_fact_month = FacturationMilk.sum(:liters, :conditions=>["date between ? and ? ",@start_date,@end_date])

    @start_date_year = DateTime.now.beginning_of_year
    @end_date_year = DateTime.now.end_of_year
    @total_fact_year = FacturationMilk.sum(:liters, :conditions=>["date between ? and ? ",@start_date_year,@end_date_year])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @facturation_milks }
    end
  end

  # GET /facturation_milks/1
  # GET /facturation_milks/1.json
  def show
    @facturation_milk = FacturationMilk.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @facturation_milk }
    end
  end

  # GET /facturation_milks/new
  # GET /facturation_milks/new.json
  def new
    @facturation_milk = FacturationMilk.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @facturation_milk }
    end
  end

  # GET /facturation_milks/1/edit
  def edit
    @facturation_milk = FacturationMilk.find(params[:id])
  end

  # POST /facturation_milks
  # POST /facturation_milks.json
  def create
    if params[:facturation_milk][:date] != ""
      @facturation_milk = FacturationMilk.find_by_date(params[:facturation_milk][:date].to_date)
    
      if @facturation_milk.nil? && params[:facturation_milk][:liters] != ""
        @facturation_milk = FacturationMilk.new(params[:facturation_milk])
        if @facturation_milk.save
          redirect_to facturation_milks_path(:month=>@facturation_milk.date.month)
        end
      else
        if params[:facturation_milk][:liters] == ""
          @facturation_milk.delete
          redirect_to facturation_milks_path(:month=>@facturation_milk.date.month)
        else
          if @facturation_milk.update_column('liters',params[:facturation_milk][:liters].to_i)
            redirect_to facturation_milks_path(:month=>@facturation_milk.date.month)
          end
        end
      end
    else
      redirect_to facturation_milks_path(:month=>DateTime.now.month)
    end
  end

  # PUT /facturation_milks/1
  # PUT /facturation_milks/1.json
  def update
    @facturation_milk = FacturationMilk.find(params[:id])

    respond_to do |format|
      if @facturation_milk.update_attributes(params[:facturation_milk])
        format.html { redirect_to @facturation_milk, notice: 'Facturation milk was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @facturation_milk.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /facturation_milks/1
  # DELETE /facturation_milks/1.json
  def destroy
    @facturation_milk = FacturationMilk.find(params[:id])
    @facturation_milk.destroy

    respond_to do |format|
      format.html { redirect_to facturation_milks_url }
      format.json { head :no_content }
    end
  end

  private

  def get_liters_for_month(month)
    @liters = Array.new(31, Hash.new)
    @month_to_rest = DateTime.now.month - month.to_i
    @start_date = DateTime.now.ago(@month_to_rest.months).beginning_of_month
    @end_date = DateTime.now.ago(@month_to_rest.months).end_of_month

    @array_liters = FacturationMilk.find(:all, :conditions=>["date between ? and ? ",@start_date,@end_date])
    
    @array_liters.each do |l|
      @liters[l.date.day-1] = l.liters
    end

    return @liters
  end
end
