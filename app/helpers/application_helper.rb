module ApplicationHelper
  def error_messages_for models
     if @cow.errors.any?
        content_tag :div, id: "error_explanation"

        t('activerecord.errors.title')

        %ul
        - @cow.errors.full_messages.each do |msg|
        %li= msg

      end
end
