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
    @title += ' '+@cow.short_ring.to_s + '('
    @title += @cow.name + ')'
    return @title
  end

  def get_name_of_name(month)
    if (month.nil?)
      return t('reproductions.update.select_month')
    else
      case month
      when 1
        return t('reproductions.table_index.january')
      when 2
        return t('reproductions.table_index.february')
      when 3
        return t('reproductions.table_index.march')
      when 4
        return t('reproductions.table_index.april')
      when 5
        return t('reproductions.table_index.may')
      when 6
        return t('reproductions.table_index.june')
      when 7
        return t('reproductions.table_index.july')
      when 8
        return t('reproductions.table_index.august')
      when 9
        return t('reproductions.table_index.september')
      when 10
        return t('reproductions.table_index.october')
      when 11
        return t('reproductions.table_index.november')
      when 12
        return t('reproductions.table_index.december')

      end
    end
  end

  def table_for(collection, classes = "", *attr_list)
    actions = false

    table_id = collection.name.tableize
    table_klazz = collection.name.constantize
    table_headers = []

    attr_list.each do |attr_name|
      if attr_name.class == Hash && !attr_name[:actions].nil?
        actions = attr_name[:actions]
      else
        table_headers << content_tag(:th, table_klazz.human_attribute_name(attr_name))
      end
    end

    if actions
      table_headers << content_tag(:th, t('actions'), class: 'table_actions')
    end

    thead = content_tag :thead, content_tag(:tr, table_headers.join(" ").html_safe)
    tbody = content_tag :tbody, render(collection)

    table = content_tag(:table, "#{thead} #{tbody}".html_safe, id: table_id, class: "table #{classes}")
    table.html_safe


      #na vista
   #   = content_tag_for :tr, tip do
  #%td
    #.tip_resume.pull-left
     # = link_to tip.title.truncate(70), tip
     # = tip_tag_list_for tip

    #= link_to content_with_icon(t("show"), "chevron-right"), tip, class: "pull-right btn "
  end
end