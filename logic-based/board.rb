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

end
