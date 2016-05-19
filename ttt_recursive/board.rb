class GameBoard

  attr_accessor :board

  def initialize(board_array = ["1", "2", "3", "4", "5", "6", "7", "8", "9"])
    @board = board_array
    @score = 10
  end

  def free_spaces
    free_spaces = []
    board.each do |space|
      free_spaces << space if ["1", "2", "3", "4", "5", "6", "7", "8", "9"].include?(space)
    end
    free_spaces
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

  def check_for_win #returns true if the board is in a win condition.
    win_lines.each do |line|
      return true if line.uniq.length == 1
    end
    return false
  end

  def who_won #returns marker of player who won.
    win_lines.each do |line|
      return line[0] if line.uniq.length == 1
    end
    nil
  end

  def check_for_tie # returns true if board is in a tie condition.
    free_spaces == [] ? true : false
  end

  def mark_board(marker, location)
    @board[location] = marker
  end

  def copy_board #returns new board object
    copied_board = Marshal.load(Marshal.dump(board))
    GameBoard.new(copied_board)
  end

  def score_move(player_marker, depth)
    if who_won == player_marker
      return @score - depth
    else
      return depth - @score
    end
  end


end
