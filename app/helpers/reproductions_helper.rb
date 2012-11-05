module ReproductionsHelper
  def get_simbol_reproduction(reproductions, cow_id)
    info_repro = Array.new(12, Hash.new)
    reproductions.each do |r|
      if (r.cow_id == cow_id)
        if (r.reproduction_simbol_id.nil?)
          info_repro[r.month-1] = "".concat(r.comment)
        else
          info_repro[r.month-1] = ReproductionSimbol.find_by_id(r.reproduction_simbol_id).simbol.concat(" "+r.comment)
        end
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
end