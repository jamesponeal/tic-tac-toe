class Player

  attr_accessor :name, :marker, :type

  def initialize(name = nil, marker = nil, type = nil)
    @name = name
    @marker = marker
    @type = type
  end

end