class KineController < ApplicationController
  before_filter :authenticate_user!
  
  # GET /kine
  # GET /kine.json
  def index
    @kine = current_user.cow.order('short_ring').is_active.page(params[:page]).per(15)
    notifications
  end
  
  # GET /kine/1
  # GET /kine/1.json
  def show
    @cow = Cow.find(params[:id])
    @reproductions = @cow.reproductions

    @last_insemination = @cow.get_last_insemination(current_user)

    if @last_insemination != []
      @exists_born = @cow.get_last_parturitiun(@last_insemination[0],current_user)

      #@num_months_pregnant = DateTime.now.month - @last_insemination[0].date.month
      @num_months_pregnant = month_difference(DateTime.now, @last_insemination[0].date)
   
      if @num_months_pregnant<=9
        @previous_lactation = @last_insemination[0].date.advance(:months=>7)
        @previous_parturition = @last_insemination[0].date.advance(:months=>9)
      else
        @last_insemination = []
      end
    end
    @current_user = current_user
  end

  # GET /kine/new
  # GET /kine/new.json
  def new
    @cow = Cow.new
  end

  # GET /kine/1/edit
  def edit
    @cow = Cow.find(params[:id])
    @cow.date_born = @cow.date_born.strftime('%d/%m/%Y')
  end

  # POST /kine
  # POST /kine.json
  def create
    if params[:cow][:parent_id] == "-1"
      params[:cow][:parent_id] = nil
    end
    @cow = current_user.cow.new(params[:cow])
    @cow.set_mother(params[:cow][:parent_id],params[:cow][:ring_mother])
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
    @cow.set_mother(params[:cow][:parent_id],params[:cow][:ring_mother])
    params[:cow][:ring_mother] = @cow.ring_mother
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
    @cow.save_mother_when_down
    @cow.save
    redirect_to kine_path
  end

  def notifications
    @notification_lactation = Cow.get_notification_lactation(current_user)
    @notification_parturition = Cow.get_notification_parturition(current_user)
    @notification_watch_next_insemination = Cow.watch_inseminations(current_user)
    @custom_notifications = Notification.is_active
  end

  def set_is_pregnant
    @cow = Cow.find(params[:id])
    @cow.set_is_pregnant(1)
    @cow.set_last_failed_insemination(nil)
    redirect_to cow_path(:id=>@cow.id)
  end

  def set_is_not_pregnant
    @cow = Cow.find(params[:id])
    @cow.set_is_pregnant(0)
    @last_insemination = @cow.get_last_insemination(current_user)
    @cow.set_last_failed_insemination(@last_insemination[0].date)
    redirect_to cow_path(:id=>@cow.id)
  end

  def remove_is_pregnant
    @cow = Cow.find(params[:cow_id])
    @cow.set_is_pregnant(0)
    @cow.decrement_num_borns
    @cow.set_is_milk(true)
    @cow.save
    redirect_to @cow
  end

  private

  def month_difference(a, b)
    @difference = 0
    if a.year != b.year
      @difference += 12 * (b.year - a.year)
    end
    @difference = @difference + b.month - a.month
    if @difference < 0
      @difference = @difference * (-1)
    end
    return @difference
  end
end

