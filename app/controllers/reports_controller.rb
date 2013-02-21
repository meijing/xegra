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
    @cow_id =''
    @cow = nil
    if !params[:cow_id].nil? and params[:cow_id]!= '-1'
      @all_children = Cow.arrange()
      @c = Cow.find(params[:cow_id])
      @cow = find_cow_ancestry(@all_children, @c )
      @actual_cow = Cow.find(params[:cow_id])
    end
    
  end

  private
  def find_cow_ancestry(all_cow, cow_id)
    all_cow.map do |cow, sub_children|
      if (cow == cow_id)
        p '---------------igual'
        p cow
        p cow_id
        p sub_children
        p all_cow
        return sub_children
      end
      if (!sub_children.nil?)
        sub_children.each do |c|
          find_cow_ancestry(c,cow_id)
        end
      end
    end
  end

end
