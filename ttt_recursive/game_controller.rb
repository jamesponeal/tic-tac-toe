require_relative 'board'
require_relative 'game_view'
require_relative 'human_player'
require_relative 'computer_player'
require_relative 'game_setup'

class GameController
  include GameSetup
  include GameView

  attr_reader :game_over, :winner
  attr_accessor :current_player, :other_player, :p1, :p2

  def initialize(board = GameBoard.new)
    @board = board
    @current_player = nil
    @game_over = false
    @winner = nil
    @p1 = nil
    @p2 = nil
  end

  def play_game
    until game_over
      print_board(@board)
      puts "#{@current_player.name} is thinking..." if @current_player.type == "computer"
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
        choice = get_human_move
      else
        choice = @current_player.get_best_move(@board, other_player.marker)
      end
      if choice == nil
        return nil
      elsif @board.valid_choice?(choice+1)
        @board.mark_board(@current_player.marker, choice)
        display_move(@current_player.name, choice)
      else
        display_invalid_input
        choice = nil
      end
    end
  end

  def get_human_move
    human_choice = ask_for_human_move(@current_player.name)
    if human_choice == "pass"
      return nil
    else
      human_choice.to_i-1
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

