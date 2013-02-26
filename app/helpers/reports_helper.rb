# encoding: utf-8
module ReportsHelper

  def nested_childrenk(children)
    if (!children.nil?)
      children.map do |children, sub_children|
        content_tag(:ul)+content_tag(:li)+
          content_tag(:input,'',:type=>'checkbox',:id=>'item-0')+
          content_tag(:label,make_info_child(children),:for => "item-0")+ content_tag(:div, nested_children(sub_children))
      end.join.html_safe
    end
  end

  def nested_children (cow, text_level)
    text = "<ul>"
    
    level = 0
    if (!cow.nil?)
      cow.map do |cow, children|
        text = text + "<li>"
        text_level = text_level + '-'+level.to_s
        if !children.nil? and children != {}
          text = text + "<input type='checkbox' id='item-"+text_level+"' /><label for='item-"+text_level+"'>"+make_info_child(cow)+"</label>"
          text = text + nested_children(children,text_level)
          level += 1
        else
          
          text = text + "<li>"+cow.name+"</li>"

        end
      end
      text = text + "</ul>"
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
