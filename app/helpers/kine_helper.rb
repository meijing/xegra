module KineHelper
  def kine_letter_filter_links_sidebar
    content_tag :div, :id=>'catalogue_filter_letters' do
      ('0'..'9').to_a.collect { |letter|
        content_tag :div, :class => 'letter_filter_letter_container clickable_container' do
          link_to letter, index_kine_filter_path(letter)
        end
      }.join(" ").html_safe
    end
  end

  def get_ring_name_cows
    @names = []
    @names << ['',-1]
    current_user.cow.is_active.with_born.each do |cow|
      @names << [cow.name + ' ('+cow.short_ring.to_s+')', cow.id]
    end
    return @names
  end

  def farm_has_notifications(notification_lactation, notification_parturition, notification_watch_next_insemination)
    if (!notification_lactation.nil? and notification_lactation != []) or 
        (!notification_parturition.nil? and notification_parturition != []) or
        (!notification_watch_next_insemination.nil? and notification_watch_next_insemination != [])
      return true
    end
    return false
  end
end
