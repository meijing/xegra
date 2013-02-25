# encoding: utf-8
module ReportsHelper

  def nested_children(children)
    if (!children.nil?)
      children.map do |children, sub_children|
        content_tag(:ul)+content_tag(:li)+
          content_tag(:input,'',:type=>'checkbox',:id=>'item-0')+
          content_tag(:label,make_info_child(children),:for => "item-0")+ content_tag(:div, nested_children(sub_children))
      end.join.html_safe
    end
  end

  def d (cow,level)
    text = "<ul>"
    text = text + "<li>"
    if (!cow.nil?)
      cow.map do |cow, children|
        if !children.nil? and children != {}
          text = text + "<input type='checkbox' id='item-"+level.to_s+"' /><label for='item-"+level.to_s+"'>"+make_info_child(cow)+"</label>"
          text = text + d(children,level+1)
        else
          text = text + "<li>"+cow.name+"</li>"
        end
      end
    end
    return text
  end

  def make_info_child(child)
    if (child != {})
    @cow =child.clone
      @info = child.name
      if (!child.father.nil? and child.father != '')
        @info += '  ~ Pai: '+child.father
      end
    end
    return @info
  end
end
