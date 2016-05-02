module GameSetup

  # Game setup
    # Determine game type
      # If human v computer or human vs human:
        # Get human name(s)
        # Get first player choice
        # Get human marker choice
    # Set player info


  def game_setup
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
    display_game_type("human vs. computer")
    who_goes_first = get_first_move_choice
    who_goes_first == "1" ? @current_player = @p1 : @current_player = @p2
    display_who_goes_first(who_goes_first)
    name = ask_player_name(who_goes_first)
    human_marker = get_marker_choice(name)
    computer_marker = get_computer_marker(human_marker)
    set_player_info(@p1, name, human_marker, "human")
    set_player_info(@p2, "Computer", computer_marker, "computer")
  end

  def setup_human_vs_human
    display_game_type("human vs. human")
    name1 = ask_player_name("1")
    marker1 = get_marker_choice(name1)
    name2 = ask_player_name("2")
    marker2 = get_marker_choice(name2)
    current_player = @p1
    set_player_info(@p1, name1, marker1, "human")
    set_player_info(@p2, name2, marker2, "human")
  end

  def setup_computer_vs_computer
    display_game_type("computer vs. computer")
    set_player_info(@p1, "Computer 1", "X", "computer")
    set_player_info(@p2, "Computer 2", "O", "computer")
  end

  def get_computer_marker(human_marker)
    human_marker == "X" ? computer_marker = "O" : computer_marker = "X"
    computer_marker
  end

  def get_marker_choice(name, marker = nil)
    until marker == 'X' || marker == 'O'
      marker = ask_player_marker(name)
      if marker != 'X' && marker != 'O'
        display_invalid_marker_choice
      end
    end
    marker
  end

  def set_player_info(player_object, name, marker, type)
    player_object.name = name
    player_object.type = type
    if marker == "X"
      player_object.marker = "\e[31;1mX\e[0m"
    else
      player_object.marker = "\e[32;1mO\e[0m"
    end
  end

  def get_game_type(game_type = nil)
    until game_type == "1" || game_type == "2" || game_type == "3"
      game_type = ask_game_type
      if game_type != "1" && game_type != "2" && game_type != "3"
        display_invalid_input
      end
    end
    game_type
  end

  def get_first_move_choice(first_move_choice = nil)
    until first_move_choice == "1" || first_move_choice == "2"
      first_move_choice = ask_who_goes_first
      if first_move_choice != "1" && first_move_choice != "2"
        display_invalid_input
      end
    end
    first_move_choice
  end

end