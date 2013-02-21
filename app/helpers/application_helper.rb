module ApplicationHelper
  def error_messages_for models
     if @cow.errors.any?
        content_tag :div, id: "error_explanation" do
          content_tag(:ul) do
            models.errors.full_messages.map do |msg|
              content_tag :li, msg
            end.join.html_safe
          end
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

  def get_cooperatives_name
    @names = []
    @names << ['',-1]
    Cooperative.all.each do |c|
      @names << [c.name, c.id]
    end
    return @names
  end
end
