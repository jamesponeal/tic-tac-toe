require_relative "game_view"
require_relative "computer_player"
require_relative "board"

class Player
  include GameView
  include ComputerPlayer

  attr_accessor :name, :marker, :type

  def initialize(name = nil, marker = nil, type = nil)
    @name = name
    @marker = marker
    @type = type
  end

  def get_human_move
    human_choice = ask_for_human_move(name)
    if human_choice == "pass"
      return nil
    else
      choice = human_choice.to_i-1
    end
    choice
  end

  def get_computer_move(board, opponent_marker)
    if immediate_move(board, marker) != nil #winning-move
      immediate_move(board, marker)
    elsif immediate_move(board, opponent_marker) != nil #block-opponent-win
      immediate_move(board, opponent_marker)
    elsif board.free_spaces.length == 9 #first_move
      random_corner_move(board)
    elsif board.free_spaces.length == 8 #second_move
      board.free_corner_spaces.length <= 3 ? 4 : random_corner_move(board)
    elsif board.free_spaces.length == 7 #third move
      board.free_side_spaces.length <= 3 ? 4 : opposite_corner_move(board)
    elsif board.free_spaces.length == 6 #fourth move
      if board.board[4] == marker && board.free_corner_spaces.length <= 2
        random_side_move(board)
      elsif board.board[4] == "5"
        4
      elsif setup_next_move(board, opponent_marker) != nil
        setup_next_move(board, opponent_marker)
      else
        random_move(board)
      end
    elsif setup_next_move(board, marker) != nil #fifth move and beyond
      setup_next_move(board, marker)
    elsif setup_next_move(board, opponent_marker) != nil
      setup_next_move(board, opponent_marker)
    else
      random_move(board)
    end
  end


end