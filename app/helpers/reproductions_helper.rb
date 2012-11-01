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
end
