module ComputerPlayer

  def random_move(board)
    board.free_spaces.sample.to_i-1
  end

  def random_corner_move(board)
    board.free_corner_spaces.sample.to_i-1
  end

  def random_side_move(board)
    board.free_side_spaces.sample.to_i-1
  end

  def opposite_corner_move(board)
    return 0 if board.board[8] == marker && board.free_spaces.include?("1")
    return 6 if board.board[2] == marker && board.free_spaces.include?("7")
    return 8 if board.board[0] == marker && board.free_spaces.include?("9")
    return 2 if board.board[6] == marker && board.free_spaces.include?("3")
    random_corner_move(board)
  end

  def immediate_move(board, marker)
    board.free_spaces.each do |space|
      board.mark_board(marker, space.to_i-1)
      if board.check_for_win
        board.mark_board(space, space.to_i-1)
        return space.to_i-1
      end
      board.mark_board(space, space.to_i-1)
    end
    return nil
  end

  def count_possible_future_wins(board, marker)
    count = 0
    board.free_spaces.each do |space|
      board.mark_board(marker, space.to_i-1)
        count += 1 if board.check_for_win
      board.mark_board(space, space.to_i-1)
    end
    count
  end

  def setup_next_move(board, marker)
    choice = nil
    high_score = 0
    board.free_spaces.each do |space|
      board.mark_board(marker, space.to_i-1)
      count = count_possible_future_wins(board, marker)
      if count > high_score
        high_score = count
        choice = space.to_i-1
      end
      board.mark_board(space, space.to_i-1)
    end
    choice
  end


end