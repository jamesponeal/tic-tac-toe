class GameView

  def print_title
    puts ""
    wait_with_line(1,0.1)
    puts "~-"*15
    wait_with_line(1,0.1)
    puts "          TIC TAC TOE"
    wait_with_line(1,0.1)
    puts "     by Command Line Games"
    wait_with_line(1,0.1)
    puts "~-"*15
    wait_with_line(1,0.1)
  end

  def print_board(board)
    wait_with_line(1,0.2)
    puts "        #{board.board[0]} | #{board.board[1]} | #{board.board[2]}"
    sleep(0.1)
    puts "       ===+===+==="
    sleep(0.1)
    puts "        #{board.board[3]} | #{board.board[4]} | #{board.board[5]}"
    sleep(0.1)
    puts "       ===+===+==="
    sleep(0.1)
    puts "        #{board.board[6]} | #{board.board[7]} | #{board.board[8]}"
    wait_with_line(1,0.2)
  end

  def ask_game_type
    wait_with_line(1,0.2)
    puts "Please choose a game play option:"
    puts "Enter '1' for human vs computer"
    puts "Enter '2' for human vs human"
    puts "Enter '3' for computer vs computer"
    gets.chomp
  end

  def display_game_type(selection)
    wait_with_line(1,0.2)
    puts "You have selected #{selection}."
  end

  def ask_who_goes_first
    wait_with_line(1,0.2)
    puts "Would you like to go 1st or 2nd (enter 1 or 2)?"
    gets.chomp
  end

  def display_who_goes_first(player_choice)
    wait_with_line(1,0.2)
    if player_choice == "1"
      puts "You have chosen to go first, the computer will go 2nd."
    elsif player_choice == "2"
      puts "You have chosen to go 2nd, the computer will go first."
    end
  end

  def ask_player_name(number)
    wait_with_line(1,0.2)
    puts "Player #{number}, please enter your name:"
    gets.chomp
  end

  def ask_player_marker(name)
    wait_with_line(1,0.2)
    puts "#{name}, what would you like to use as your marker (X or O)?"
    gets.chomp
  end

  def display_move(player, choice)
    wait_with_line(1,0.2)
    puts "#{player.name} has selected #{choice+1}."
  end

  def ask_for_human_move(player)
    wait_with_line(1,0.2)
    puts "#{player.name}, please choose a space:"
    gets.chomp
  end

  def display_end_game(winner)
    wait_with_line(1,0.2)
    if winner == "tie"
      puts "Game Over!!! The game ended in a tie!"
    elsif winner.type == "human"
      puts "Game Over!!! Congratulations #{winner.name}, you won!!"
    else
      puts "Game Over!!! Unfortunately you lost to the computer. Better luck next time!"
    end
    wait_with_line(1,0.2)
  end

  def display_invalid_input
    wait_with_line(1,0.2)
    puts "I didn't understand your input, please try again."
  end

  def wait_with_line(number, seconds)
    number.times do
      sleep(seconds)
      puts ""
    end
  end

end