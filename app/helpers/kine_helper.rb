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
end
