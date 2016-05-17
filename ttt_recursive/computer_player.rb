require_relative "player"

class ComputerPlayer < Player

  attr_accessor :name, :marker, :type

  def initialize(name = nil, marker = nil, type = nil)
    super(name, marker, type)
  end


# Computer move:
  # 1. Copy board
    # 1.1 Get available spaces and iterate through them
    # 1.2 Place mark on next available space.
    # 1.3 Check for game win or loss
      # If win, return +10
      # If loss, return -10
      # else switch player & repeat 1.1

  def score_available_moves(board, opponent_marker)
    scores = {}
    board.free_spaces.each do |space|
      copied_board = board.copy_board
      scores[space] = copied_board.get_score(marker, opponent_marker, marker, space.to_i-1)
    end
    scores
  end



end