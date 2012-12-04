module ReproductionsHelper
  def get_simbol_reproduction(reproductions, cow_id)
    info_repro = Array.new(12, Hash.new)
    reproductions.each do |r|
      if (r.cow_id == cow_id)
        if (r.reproduction_simbol_id.nil?)
          info_repro[r.month-1] = "".concat(r.comment)
        else
          info_repro[r.month-1] = ReproductionSimbol.find_by_id(r.reproduction_simbol_id).simbol.concat(" "+r.comment)+'<br/>'
          if (!r.bull.nil?)
            info_repro[r.month-1] = info_repro[r.month-1] + '<br/>'+r.bull
          end
          if (!r.date.nil?)
            info_repro[r.month-1] = info_repro[r.month-1] + '<br/>'+ r.date.strftime('%d/%m/%Y')
          end
        end
        info_repro[r.month-1] = info_repro[r.month-1].html_safe
      end
    end
    return info_repro
  end

  def get_text_simbol_reproduction(reproduction)
    @text = ""
    @simbol = ReproductionSimbol.find_by_id(reproduction.reproduction_simbol_id)
    if !@simbol.nil?
      @text += @simbol.simbol
    end

    @text += "<br />"+reproduction.comment
    return @text
  end

  def get_title_individual_repro_page(cow)
    @title = 'Modifica a carta de reproduccion para a vaca '
    @title += @cow.ring + '('
    @title += @cow.name + ')'
    return @title
  end

  def get_name_of_name(month)
    if (month.nil?)
      return '(Seleccione un mes)'
    else
      case month
      when 1
        return 'Xaneiro'
      when 2
        return 'Febreiro'
      when 3
        return 'Marzo'
      when 4
        return 'Abril'
      when 5
        return 'Maio'
      when 6
        return 'Xunho'
      when 7
        return 'Xullo'
      when 8
        return 'Agosto'
      when 9
        return 'Setembro'
      when 10
        return 'Outubro'
      when 11
        return 'Novembro'
      when 12
        return 'Decembro'

      end
    end
  end
end