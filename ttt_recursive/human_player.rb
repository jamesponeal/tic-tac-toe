require_relative "player"

class HumanPlayer < Player

  attr_accessor :name, :marker, :type

  def initialize(name = nil, marker = nil, type = nil)
    super(name, marker, type)
  end

  def get_human_move
    human_choice = ask_for_human_move(name)
    if human_choice == "pass"
      return nil
    else
      human_choice.to_i-1
    end
  end

end