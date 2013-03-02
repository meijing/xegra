class ReportsController < ApplicationController
  def index
    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def active_cow
    @cows = current_user.cow.order('is_pregnant,short_ring').is_active
    @title = t('reports.activated_cow')
    render 'report_cow'
  end

  def pregnant_cow
    @cows = current_user.cow.order('is_pregnant,short_ring').is_active.is_pregnant.with_born
    @title = t('reports.pregnant_cow')
    render 'report_cow'
  end

  def not_pregnant_cow
    @cows = current_user.cow.order('is_pregnant,short_ring').is_active.is_not_pregnant.with_born
    @title = t('reports.not_pregnant_cow')
    render 'report_cow'
  end

  def is_milk_cow
    @cows = current_user.cow.order('is_pregnant,short_ring').is_active.is_milk.with_born
    @title = t('reports.lactation_cow')
    render 'report_cow'
  end

  def is_not_milk_cow
    @cows = current_user.cow.order('is_pregnant,short_ring').is_active.is_not_milk.with_born
    @title = t('reports.not_lactation_cow')
    render 'report_cow'
  end

  def cow_without_born
    @cows = current_user.cow.order('is_pregnant,short_ring').is_active.without_born
    @title = t('reports.cow_without_born')
    render 'report_cow'
  end

  def total_facturation
    @title = t('reports.total_facturation_milk')
    @cont_liters = FacturationMilk.get_totals_for_month(current_user)
  end

  def tree_familiar
    @title = t('reports.tree_familiar')
    
    @all_children = current_user.cow
    @cows_to_delete = []
    @all_children = @all_children.arrange()
    
    @all_children.map do |cow, sub_children|
      @check = false
      if (cow.is_active != 1)
        @c = check_exists_active_cows(sub_children)
        if !@c
          @cows_to_delete << cow
        end
      end
      
    end

    @cows_to_delete.each do |d|
       @all_children.delete(d)
    end
    p '--------------------'
    p @all_children
  end

  private
  def check_exists_active_cows(sub_children)
    @check = false
    sub_children.map do |c, sc|
      if c.is_active == 1
        return true
      end
      @check = check_exists_active_cows(sc)
    end
    return @check
  end

end
