class FacturationMilksController < ApplicationController
  # GET /facturation_milks
  # GET /facturation_milks.json
  def index
    @month = params[:month]
    @initial_date = DateTime.now.year.to_s+"-12-01"
    @initial_date = @initial_date.to_date
    @month_to_rest = @initial_date.month - @month.to_i
    @start_date = @initial_date.ago(@month_to_rest.months).beginning_of_month
    @end_date = @initial_date.ago(@month_to_rest.months).end_of_month

    @facturation_milks = current_user.FacturationMilk.find(:all, :conditions=>["date between ? and ? ",@start_date,@end_date])

    @last_day = @end_date.day
    
    @liters = get_liters_for_month(@month)
    @total_fact_month = current_user.FacturationMilk.sum(:liters, :conditions=>["date between ? and ? ",@start_date,@end_date])

    @start_date_year = DateTime.now.beginning_of_year
    @end_date_year = DateTime.now.end_of_year
    @total_fact_year = current_user.FacturationMilk.sum(:liters, :conditions=>["date between ? and ? ",@start_date_year,@end_date_year])
    
  end

  # GET /facturation_milks/1
  # GET /facturation_milks/1.json
  def show
    @facturation_milk = current_user.FacturationMilk.find(params[:id])
  end

  # GET /facturation_milks/new
  # GET /facturation_milks/new.json
  def new
    @facturation_milk = FacturationMilk.new
  end

  # GET /facturation_milks/1/edit
  def edit
    @facturation_milk = current_user.FacturationMilk.find(params[:id])
  end

  # POST /facturation_milks
  # POST /facturation_milks.json
  def create
    if params[:facturation_milk][:date] != ""
      @facturation_milk = current_user.FacturationMilk.find_by_date(params[:facturation_milk][:date].to_date)

      if @facturation_milk.nil? && params[:facturation_milk][:liters] != ""
        @facturation_milk = FacturationMilk.new(params[:facturation_milk])
        @facturation_milk.user_id = current_user.id
        if @facturation_milk.save
          p 'saved'
          redirect_to facturation_milks_path(:month=>@facturation_milk.date.month)
        end
      else
        if params[:facturation_milk][:liters] == ""
          if !@facturation_milk.nil?
            @facturation_milk.delete
            redirect_to facturation_milks_path(:month=>@facturation_milk.date.month)
          else
            redirect_to facturation_milks_path(:month=>DateTime.now.month)
          end
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
    @facturation_milk = current_user.FacturationMilk.find(params[:id])

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
    p '--------'
    
    if !params[:facturation_milk].nil? and params[:facturation_milk][:date] != ""
      p '-------------------------'
      p params[:facturation_milk][:date]
      @facturation_milk = current_user.FacturationMilk.find_by_date(params[:facturation_milk][:date].to_date)
      p @facturation_milk
      if !@facturation_milk.nil?
        @facturation_milk.destroy
      end
      redirect_to facturation_milks_path(:month=>@facturation_milk.date.month)
    end
    
    redirect_to facturation_milks_path(:month=>DateTime.now.month)
  end

  private

  def get_liters_for_month(month)
    @liters = Array.new(31, Hash.new)
    @initial_date = DateTime.now.year.to_s+"-12-01"
    @initial_date = @initial_date.to_date
    @month_to_rest = @initial_date.month - month.to_i
    @start_date = @initial_date.ago(@month_to_rest.months).beginning_of_month
    @end_date = @initial_date.ago(@month_to_rest.months).end_of_month

    @array_liters = current_user.FacturationMilk.find(:all, :conditions=>["date between ? and ? ",@start_date,@end_date])
    
    @array_liters.each do |l|
      @liters[l.date.day-1] = l.liters
    end

    return @liters
  end
end
