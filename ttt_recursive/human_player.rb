require_relative "player"

class HumanPlayer < Player

  def initialize(name = nil, marker = nil, type = "human")
    super(name, marker, type)
  end

end