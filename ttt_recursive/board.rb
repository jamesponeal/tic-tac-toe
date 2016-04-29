class GameBoard

  attr_accessor :board

  def initialize(board_array = ["1", "2", "3", "4", "5", "6", "7", "8", "9"])
    @board = board_array
  end

  def get_empty_spaces
    empty_spaces = []
    board.each do |space|
      empty_spaces << space if ["1", "2", "3", "4", "5", "6", "7", "8", "9"].include?(space)
    end
    empty_spaces
  end

  def get_empty_corner_spaces
    corner_spaces = []
    get_empty_spaces.each do |space|
      corner_spaces << space if ["1", "3", "7", "9"].include?(space)
    end
    corner_spaces
  end

  def get_empty_side_spaces
    side_spaces = []
    get_empty_spaces.each do |space|
      side_spaces << space if ["2", "4", "6", "8"].include?(space)
    end
    side_spaces
  end

  def random_move
    get_empty_spaces.sample.to_i-1
  end

  def random_corner_move
    get_empty_corner_spaces.sample.to_i-1
  end

  def random_side_move
    get_empty_side_spaces.sample.to_i-1
  end

  def opposite_corner_move(marker)
    return 8 if board[0] == marker && get_empty_spaces.include?("9")
    return 0 if board[8] == marker && get_empty_spaces.include?("1")
    return 6 if board[2] == marker && get_empty_spaces.include?("7")
    return 2 if board[6] == marker && get_empty_spaces.include?("3")
    random_corner_move
  end

  def valid_choice?(choice)
    (1..9).include?(choice) && get_empty_spaces.include?(choice.to_s) ? true : false
  end

  def win_lines
    [[board[0], board[1], board[2]],
    [board[3], board[4], board[5]],
    [board[6], board[7], board[8]],
    [board[0], board[3], board[6]],
    [board[1], board[4], board[7]],
    [board[2], board[5], board[8]],
    [board[0], board[4], board[8]],
    [board[2], board[4], board[6]]]
  end

  def check_for_win
    win_lines.each do |line|
      return true if line.uniq.length == 1
    end
    return false
  end

  def check_for_tie
    get_empty_spaces == [] ? true : false
  end

  def mark_board(marker, location)
    @board[location] = marker
  end

  def check_for_immediate_move(marker)
    get_empty_spaces.each do |space|
      mark_board(marker, space.to_i-1)
      if check_for_win
        mark_board(space, space.to_i-1)
        return space.to_i-1
      end
      mark_board(space, space.to_i-1)
    end
    return nil
  end

  def determine_winner
    win_lines.each do |line|
      if line.uniq.length == 1
        return line[0]
      end
    end
    return nil
  end


  def switch_marker(player, opponent, marker)
    if marker == player.marker
      marker = opponent.marker
    else
      marker = player.marker
    end
    marker
  end

  def check_for_best_move(player, opponent, marker)
    get_empty_spaces.each do |space|
      mark_board(marker, space.to_i-1)
      if determine_winner == player.marker
        return 10
      elsif determine_winner == opponent.marker
        return -10
      elsif get_empty_spaces.length == 0
        return 0
      else
        marker = switch_marker(player, opponent, marker)
        return check_for_best_move(player, opponent, marker)
      end
    end
  end


  def get_scores(player, opponent, marker)
    temp_board = copy_board
    score_hash = {}
    get_empty_spaces.each do |space|
      score_hash[space] = check_for_best_move(player, opponent, marker)
    end
    @board = temp_board
    p score_hash
  end

  def copy_board
    @board
  end


  # def check_for_best_move(player, opponent, marker)
  #   get_empty_spaces.each do |space|
  #     score = score_move(player, opponent, marker, space)
  #     if score > high_score
  #       choice = space.to_i-1
  #       high_score = score
  #     elsif get_empty_spaces.length != 0
  #       marker = switch_marker(player, opponent, marker)
  #       score += check_for_best_move(player, opponent, marker)
  #     end
  #     mark_board(space, space.to_i-1)
  #   end
  #   choice
  # end


  def find_best_move(player, opponent)
    best_move = nil
    if check_for_immediate_move(player.marker) != nil #winning-move
      best_move = check_for_immediate_move(player.marker)
    elsif check_for_immediate_move(opponent.marker) != nil #block-opponent-win
      best_move = check_for_immediate_move(opponent.marker)
    # elsif get_empty_spaces.length == 9 #first_move
    #   best_move = random_corner_move
    # elsif get_empty_spaces.length == 8 #second_move
    #   if get_empty_corner_spaces.length <= 3
    #     best_move = 4 #if opponent went corner, go center.
    #   else
    #     best_move = random_corner_move #if opponent didn't go corner, go corner.
    #   end
    # elsif get_empty_spaces.length == 7 #third move (computer's 2nd move)
    #   if get_empty_side_spaces.length <= 3
    #     best_move = 4
    #   else
    #     best_move = opposite_corner_move(player.marker)
    #   end
    # elsif get_empty_spaces.length == 6 #fourth move side
    #   if board[4] == player.marker
    #     best_move = random_side_move
    #   elsif check_for_fork_move(player.marker) != nil
    #     best_move = check_for_fork_move(player.marker)
    #   else
    #     best_move = random_move
    #   end
    # elsif check_for_future_move(opponent.marker) != nil
    #   best_move = check_for_future_move(opponent.marker)
    # elsif check_for_future_move(player.marker) != nil
    #   best_move = check_for_future_move(player.marker)
    else
      puts "get_scores!!!"
      get_scores(player, opponent, player.marker)
    # else
    #   best_move = random_move
    #   puts "Random Move: #{best_move}"
    end
    best_move
  end

end


# Computer logic in order of preference:
# 1. Win: If a choice exists that will result in a win, go there.
# 2. Block: If the opponent can make a move that will result in a win for them on their next move, go there to block them.
# 3. If the board is clear, pick a corner.
# 4. If there is one mark on the board and it's a corner, then go middle, else, go corner.
# 5. If there are two marks: if opponent mark is on a side, go middle, else if opposite corner is open, go there, else go in a random corner.
# 6. If there are three marks and computer mark is in the middle, then go side.
# 7. Block fork.
# 7. Create fork.
# 8. Random corner.
# 9. Random space.
