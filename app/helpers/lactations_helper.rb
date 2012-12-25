module LactationsHelper
  def get_header_show(cow)
    return t('lactations.show.to_cow')+' '+cow.short_ring.to_s + ' ('+cow.name+')'
  end

  def get_month_lactation(month)
    return t('lactations.show.for_month')+' '+ get_name_of_name(month.to_i)
  end
end
