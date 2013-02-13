class NotificationsController < ApplicationController
  # GET /notifications
  # GET /notifications.json
  def index
    @notifications_active = Notification.is_active
    @notifications_desactive = Notification.is_desactive

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /notifications/1
  # GET /notifications/1.json
  def show
    @notification = Notification.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @notification }
    end
  end

  # GET /notifications/new
  # GET /notifications/new.json
  def new
    @notification = Notification.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @notification }
    end
  end

  # GET /notifications/1/edit
  def edit
    @notification = Notification.find(params[:id])
  end

  # POST /notifications
  # POST /notifications.json
  def create
    @notification = Notification.new(params[:notification])

    respond_to do |format|
      @notification.active = 1
      if @notification.save
        format.html { redirect_to notifications_path}
        format.json { render json: @notification, status: :created, location: @notification }
      else
        format.html { render action: "new" }
        format.json { render json: @notification.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /notifications/1
  # PUT /notifications/1.json
  def update
    @notification = Notification.find(params[:id])

    respond_to do |format|
      if @notification.update_attributes(params[:notification])
        format.html { redirect_to notifications_path}
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @notification.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notifications/1
  # DELETE /notifications/1.json
  def destroy
    @notification = Notification.find(params[:id])
    @notification.destroy

    respond_to do |format|
      format.html { redirect_to notifications_url }
      format.json { head :no_content }
    end
  end

  def notifications_is_not_milk
    @cow = Cow.find(params[:cow_id])
    @cow.set_is_milk(false)
    redirect_to notifications_path
  end

  def index_active_notifications
    @notification_lactation = Cow.get_notification_lactation(current_user)
    @notification_parturition = Cow.get_notification_parturition(current_user)
    @notification_watch_next_insemination = Cow.watch_inseminations(current_user)
    @custom_notifications = Notification.is_active.check_custom_notifications
  end

  def desactive_notification
    @notification = Notification.find(params[:id])
    @notification.desactive
    redirect_to notifications_path
  end

  def active_notification
    @notification = Notification.find(params[:id])
    @notification.active
    redirect_to notifications_path
  end
end
