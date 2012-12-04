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
end
