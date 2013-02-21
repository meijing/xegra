# encoding: utf-8
module ReportsHelper

  def nested_children(children)
    if (!children.nil?)
      children.map do |children, sub_children|
        content_tag(:p,make_info_child(children), :class => "nested_messages")+ content_tag(:div, nested_children(sub_children), :class => "nested_messages")
      end.join.html_safe
    end
  end

  def make_info_child(child)
    if (child != {})
    @cow =child.clone
      @info = '> '+child.name
      if (!child.father.nil? and child.father != '')
        @info += '  ~ Pai: '+child.father
      else
        @info += '   (Non se especificou o nome do pai)'
      end
    end
  end
end
