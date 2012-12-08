module LactationsHelper
  def get_header_show(cow)
    return 'Control leiteiro para a vaca '+cow.ring + ' ('+cow.name+')'
  end

  def get_month_lactation(month)
    return 'Datos para o mes de ' + get_name_of_name(month.to_i)
  end
end
