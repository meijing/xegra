module NotificationsHelper

  def get_all_cows
    @names = []
    @names << ['',-1]
    current_user.cow.is_active.each do |cow|
      @names << [cow.name + ' ('+cow.short_ring.to_s+')', cow.id]
    end
    return @names
  end
end
