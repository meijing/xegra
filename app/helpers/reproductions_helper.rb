# encoding: utf-8
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
    @title = t('reproductions.update.title')
    @title += ' '+cow.short_ring.to_s + '('
    @title += cow.name + ')'
    return @title
  end

end