# encoding: utf-8
module ReportsHelper

  def nested_children (cow, text_level)
    text = "<ul>"
    
    level = 0
    if (!cow.nil?)
      cow.map do |cow, children|
        text = text + "<li>"
        text_level = text_level + '-'+level.to_s
        if !children.nil? and children != {}
          text = text + "<input type='checkbox' id='item-"+text_level+"' /><label for='item-"+text_level+"'><span>"+make_info_child(cow)+"</span></label>"
          text = text + nested_children(children,text_level)
          level += 1
        else
          
          text = text + "<li><span>"+make_info_child(cow)+"</span></li>"

        end
      end
      text = text + "</ul>"
    end
    return text
  end

  def make_info_child(cow)
    @text = cow.name + "("+cow.short_ring.to_s+")"
    if !cow.father.nil? and cow.father != ""
      @text = @text + "  ~ Pai: "+cow.father
    end

    if cow.is_active != 1
      @text = @text + '<span style="color:red"> A vaca xa non está na granxa</span>'
    end
    return @text
  end
end
