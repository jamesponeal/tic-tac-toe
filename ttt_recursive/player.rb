class Player

  attr_reader :name, :marker, :type

  def initialize(name, marker, type)
    @name = name
    @marker = marker
    @type = type
  end

end