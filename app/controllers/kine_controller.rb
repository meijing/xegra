class KineController < ApplicationController
  # GET /kine
  # GET /kine.json
  def index
    @kine = Cow.order('short_ring').where('is_active=1').page(params[:page]).per(15)
    @notification_lactation = get_notification_lactation()
    @notification_parturition = get_notification_parturition()
    
    respond_to do |format|
      format.html # index.html.erb
    end
  end
  
  # GET /kine/1
  # GET /kine/1.json
  def show
    @cow = Cow.find(params[:id])
    @reproductions = Reproduction.find_by_cow_id(@cow.id)

    @last_insemination = get_last_insemination(@cow)
    p'-------------------'
    p @last_insemination
    if @last_insemination != []
      @exists_born = Reproduction.find(:all,:conditions=>['cow_id = ? and date between ? and ? and reproduction_simbol_id = 6 or reproduction_simbol_id=7',@cow.id,@last_insemination[0].date,DateTime.now])
      p @exists_born
      p @cow
      @num_months_pregnant = DateTime.now.month - @last_insemination[0].date.month
      
      if @num_months_pregnant<=9
        @previous_lactation = @last_insemination[0].date.advance(:months=>7)
        @previous_parturition = @last_insemination[0].date.advance(:months=>9)
      else
        @last_insemination = []
      end
    end
    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /kine/new
  # GET /kine/new.json
  def new
    @cow = Cow.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @cow }
    end
  end

  # GET /kine/1/edit
  def edit
    @cow = Cow.find(params[:id])
    @cow.date_born = @cow.date_born.strftime('%d/%m/%Y')
  end

  # POST /kine
  # POST /kine.json
  def create
    @cow = Cow.new(params[:cow])
    @cow.is_active=1
    @cow.short_ring = @cow.ring[@cow.ring.length-4..@cow.ring.length]
    respond_to do |format|
      if @cow.save
        format.html { redirect_to @cow, notice: 'Cow was successfully created.' }
        format.json { render json: @cow, status: :created, location: @cow }
      else
        format.html { render action: "new" }
        format.json { render json: @cow.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /kine/1
  # PUT /kine/1.json
  def update
    @cow = Cow.find(params[:id])
    @cow.short_ring = @cow.ring[@cow.ring.length-4..@cow.ring.length]
    respond_to do |format|
      if @cow.update_attributes(params[:cow])
        format.html { redirect_to @cow, notice: 'Cow was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @cow.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /kine/1
  # DELETE /kine/1.json
  def destroy
    @cow = Cow.find(params[:id])
    @cow.is_active = 0
    #@cow.date_down = Time.new
    @cow.save

    respond_to do |format|
      format.html { redirect_to kine_url }
      format.json { head :no_content }
    end
  end

  def notifications
    @notification_lactation = get_notification_lactation()
    @notification_parturition = get_notification_parturition()
  end

  def set_is_pregnant
    @cow = Cow.find(params[:id])
    @cow.update_column('is_pregnant',1)
    @cow.update_column('last_failed_insemination',nil)
    redirect_to cow_path(:id=>@cow.id)
  end

  def set_is_not_pregnant
    @cow = Cow.find(params[:id])
    @cow.update_column('is_pregnant',0)
    @last_insemination = get_last_insemination(@cow)
    @cow.update_column('last_failed_insemination',@last_insemination[0].date)
    redirect_to cow_path(:id=>@cow.id)
  end

  private

  def get_notification_lactation()
    @notifications = []
  
    @start_date = DateTime.now.ago(7.months)
    @end_date = DateTime.now.advance(:days => 5).ago(7.months)
  
    @reproductions = Reproduction.find(:all, :conditions=>["date between ? and ? ",@start_date,@end_date])
  
    @reproductions.each do |r|
      if r.cow.is_milk
        @notifications << r.cow.short_ring.to_s+' ('+r.cow.name+') - '+r.date.strftime("%d/%m/%Y")
      end
    end
    return @notifications
  end

  def get_notification_parturition()
    @notifications = []

    @start_date = DateTime.now.ago(9.months)
    @end_date = DateTime.now.advance(:days => 5).ago(9.months)

    @reproductions = Reproduction.find(:all, :conditions=>["date between ? and ? ",@start_date,@end_date])

    @reproductions.each do |r|
      @notifications << r.cow.short_ring.to_s+' ('+r.cow.name+') - '+r.date.strftime("%d/%m/%Y")
    end
    return @notifications
  end

  def get_last_insemination(cow)
    return Reproduction.where('cow_id = '+cow.id.to_s+' and date = (select max(date) from reproductions where cow_id = '+cow.id.to_s+' and reproduction_simbol_id = 11)')
  end
end

