require_relative 'board'
require_relative 'game_view'
require_relative 'player'
require_relative 'game_setup'

class GameController
  include GameSetup
  include GameView

  def initialize(board = GameBoard.new)
    @board = board
    @current_player = nil
    @game_over = false
    @winner = nil
    @p1 = Player.new
    @p2 = Player.new
    print_title
    game_setup
  end

  def play_game
    until game_over
      print_board(@board)
      play_turn
      check_for_game_over(@current_player)
      switch_player
    end
    print_board(@board)
    display_end_game(winner)
  end

  def play_turn
    choice = nil
    until choice
      if @current_player.type == "human"
        choice = @current_player.get_human_move
      else
        opponent_marker = other_player.marker
        choice = @current_player.get_computer_move(@board, opponent_marker)
      end
      if @board.valid_choice?(choice+1)
        @board.mark_board(@current_player.marker, choice)
        display_move(@current_player.name, choice)
      else
        display_invalid_input
        choice = nil
      end
    end
  end

  def check_for_game_over(player)
    if @board.check_for_tie
      @game_over = true
      @winner = "tie"
    elsif @board.check_for_win
      @game_over = true
      @winner = player
    end
  end

  def other_player
    if @current_player == @p1
      return @p2
    else
      return @p1
    end
  end

  def switch_player
    @current_player == @p1 ? @current_player = @p2 : @current_player = @p1
  end

end

