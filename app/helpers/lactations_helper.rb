module LactationsHelper
  def get_header_show(cow)
    return 'Control leiteiro para a vaca '+cow.ring + ' ('+cow.name+')'
  end
end
