require_relative 'board'
require_relative 'game_view'
require_relative 'player'

class GameController

  attr_accessor :game_over, :winner

  def initialize(board = GameBoard.new)
    @view = GameView.new
    @board = board
    @current_player = nil
    @game_over = false
    @winner = nil
    @p1 = Player.new
    @p2 = Player.new
  end

  # Game setup

  def game_setup
    @view.print_title
    game_type = get_game_type
    if game_type == "1" #human vs computer
      setup_human_vs_computer
    elsif game_type == "2" #human vs human
      setup_human_vs_human
    elsif game_type == "3" #computer vs computer
      setup_computer_vs_computer
    end
  end

  def setup_human_vs_computer
    @view.display_game_type("human vs. computer")
    who_goes_first = get_first_move_choice

    @view.display_who_goes_first(who_goes_first)
    if who_goes_first == "1"
      name1 = @view.ask_player_name(who_goes_first)
      create_players(name1, "human", "Computer", "computer")
    else
      name2 = @view.ask_player_name(who_goes_first)
      create_players("Computer", "computer", name2, "human")
    end
  end

  def setup_human_vs_human
    @view.display_game_type("human vs. human")
    name1 = @view.ask_player_name("1")
    name2 = @view.ask_player_name("2")
    create_players(name1, "human", name2, "human")
  end

  def setup_computer_vs_computer
    @view.display_game_type("computer vs. computer")
    create_players("Computer 1", "computer", "Computer 2", "computer")
  end


  def get_marker_choice(name)
    until marker == 'X' || marker == 'O'
      marker = @view.ask_player_marker(name1)
      if marker != 'X' && marker != 'O'
        @view.display_invalid_marker_choice
      end
    end
  end

  def create_players(name1, type1, name2, type2)
    marker1 = "\e[31;1m#{@view.ask_player_marker(name1)}\e[0m"
    @p1 = Player.new(name1, marker1, type1)
    marker2 = "\e[32;1m#{@view.ask_player_marker(name2)}\e[0m"
    @p2 = Player.new(name2, marker2, type2)
  end

  def get_game_type(game_type = nil)
    until game_type == "1" || game_type == "2" || game_type == "3"
      game_type = @view.ask_game_type
      if game_type != "1" && game_type != "2" && game_type != "3"
        @view.display_invalid_input
      end
    end
    game_type
  end

  def get_first_move_choice(first_move_choice = nil)
    until first_move_choice == "1" || first_move_choice == "2"
      first_move_choice = @view.ask_who_goes_first
      if first_move_choice != "1" && first_move_choice != "2"
        @view.display_invalid_input
      end
    end
    first_move_choice
  end

  def play_game
    until game_over
      @view.print_board(@board)
      play_turn(@p1, @p2)
      check_for_game_over(@p1)
      if game_over == false
        @view.print_board(@board)
        play_turn(@p2, @p1)
        check_for_game_over(@p2)
      end
    end
    @view.print_board(@board)
    @view.display_end_game(@winner)
  end

  def play_turn(player, opponent)
    choice = nil
    until choice
      if player.type == "human"
        human_input = @view.ask_for_human_move(player)
        if human_input == "pass"
          return nil
        else
          choice = human_input.to_i-1
        end
      elsif player.type == "computer"
        choice = @board.find_best_move(player, opponent)
      end
      if @board.valid_choice?(choice+1)
        @board.mark_board(player.marker, choice)
        @view.display_move(player, choice)
      else
        @view.display_invalid_input
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

  def switch_player
    current_player == @p1 ? @p2 : @p1
  end

end

