class ReportsController < ApplicationController
  def index
    respond_to do |format|
      format.html # index.html.erb
    end
  end
<<<<<<< HEAD

  def active_cow
    @cows = current_user.cow.is_active
    render 'report_cow'
  end

  def pregnant_cow
    @cows = current_user.cow.is_active.is_pregnant
    render 'report_cow'
  end

  def not_pregnant_cow
    @cows = current_user.cow.is_active.is_not_pregnant
    render 'report_cow'
  end

  def is_milk_cow
    @cows = current_user.cow.is_active.is_milk
    render 'report_cow'
  end

  def is_not_milk_cow
    @cows = current_user.cow.is_active.is_not_milk
    render 'report_cow'
  end

  def total_facturation
    @cont_liters = FacturationMilk.get_totals_for_month(current_user)
  end
=======
>>>>>>> 8a628537b6a1c74fd1e7211fa52c172f9df328f5
end
