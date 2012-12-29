# encoding: utf-8
module ReproductionsHelper
  def get_simbol_reproduction(reproductions, cow_id)
    @info_repro = Array.new(12, [])
    reproductions.each do |r|
      if (r.cow_id == cow_id)
        @content = ""
        if (r.reproduction_simbol_id.nil?)
          @content = @content.concat(r.comment)
        else
          @content = @content + ReproductionSimbol.find_by_id(r.reproduction_simbol_id).simbol.concat(" "+r.comment)+'<br/>'
          if (!r.bull.nil?)
            @content = @content +'<br/>'+r.bull
          end
          if (!r.date.nil?)
            @content = @content + '<br/>'+ r.date.strftime('%d/%m/%Y')
          end
        end

        if @info_repro[r.month-1] == []
          @info_repro[r.month-1] = [@content.html_safe]
        else
          @info_repro[r.month-1] << @content.html_safe
        end
      end
    end
    return @info_repro
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

  def get_array_months
    @month_names = []
    (1..12).each do |m|
      @month_names << [get_name_of_name(m.to_i),m.to_i]
    end
    return @month_names
  end

end