class GameBoard

  attr_accessor :board

  def initialize(board_array = ["1", "2", "3", "4", "5", "6", "7", "8", "9"])
    @board = board_array
  end

  def free_spaces
    free_spaces = []
    board.each do |space|
      free_spaces << space if ["1", "2", "3", "4", "5", "6", "7", "8", "9"].include?(space)
    end
    free_spaces
  end

  def free_corner_spaces
    corner_spaces = []
    free_spaces.each do |space|
      corner_spaces << space if ["1", "3", "7", "9"].include?(space)
    end
    corner_spaces
  end

  def free_side_spaces
    side_spaces = []
    free_spaces.each do |space|
      side_spaces << space if ["2", "4", "6", "8"].include?(space)
    end
    side_spaces
  end

  def random_move
    free_spaces.sample.to_i-1
  end

  def random_corner_move
    free_corner_spaces.sample.to_i-1
  end

  def random_side_move
    free_side_spaces.sample.to_i-1
  end

  def opposite_corner_move(marker)
    return 8 if board[0] == marker && free_spaces.include?("9")
    return 0 if board[8] == marker && free_spaces.include?("1")
    return 6 if board[2] == marker && free_spaces.include?("7")
    return 2 if board[6] == marker && free_spaces.include?("3")
    random_corner_move
  end

  def valid_choice?(choice)
    (1..9).include?(choice) && free_spaces.include?(choice.to_s) ? true : false
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
    free_spaces == [] ? true : false
  end

  def mark_board(marker, location)
    @board[location] = marker
  end

  def immediate_move(marker)
    free_spaces.each do |space|
      mark_board(marker, space.to_i-1)
      if check_for_win
        mark_board(space, space.to_i-1)
        return space.to_i-1
      end
      mark_board(space, space.to_i-1)
    end
    return nil
  end

  def count_possible_future_wins(marker)
    count = 0
    free_spaces.each do |space|
      mark_board(marker, space.to_i-1)
        count += 1 if check_for_win
      mark_board(space, space.to_i-1)
    end
    count
  end

  def setup_next_move(marker)
    choice = nil
    high_score = 0
    free_spaces.each do |space|
      mark_board(marker, space.to_i-1)
      count = count_possible_future_wins(marker)
      if count > high_score
        high_score = count
        choice = space.to_i-1
      end
      mark_board(space, space.to_i-1)
    end
    choice
  end

  def find_best_move(player, opponent)
    if immediate_move(player.marker) != nil #winning-move
      immediate_move(player.marker)
    elsif immediate_move(opponent.marker) != nil #block-opponent-win
      immediate_move(opponent.marker)
    elsif free_spaces.length == 9 #first_move
      random_corner_move
    elsif free_spaces.length == 8 #second_move
      free_corner_spaces.length <= 3 ? 4 : random_corner_move
    elsif free_spaces.length == 7 #third move
      free_side_spaces.length <= 3 ? 4 : opposite_corner_move(player.marker)
    elsif free_spaces.length == 6 #fourth move
      if board[4] == player.marker && free_corner_spaces.length <= 2
        random_side_move
      elsif board[4] == "5"
        4
      elsif setup_next_move(opponent.marker) != nil
        setup_next_move(opponent.marker)
      else
        random_move
      end
    elsif setup_next_move(player.marker) != nil #fifth move and beyond
      setup_next_move(player.marker)
    elsif setup_next_move(opponent.marker) != nil
      setup_next_move(opponent.marker)
    else
      random_move
    end
  end

end


# Computer logic in order of preference:
# 1. Win: If a choice exists that will result in a win, go there.
# 2. Block: If the opponent can make a move that will result in a win for them on their next move, go there to block them.
# 3. If the board is clear, pick a corner.
# 4. If there is one mark on the board and it's a corner, then go middle, else, go corner.
# 5. If there are two marks: if opponent mark is on a side, go middle, else if opposite corner is open, go there, else go in a random corner.
# 6. If there are three marks and computer mark is in the middle and opponent marks are in corners, then go side, else if computer mark is not in middle, go middle, else opponent setup move.
# 7. Place setup move.
# 8. Block setup move.
# 9. Random space. Should never get here.
