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


# Computer move:
  # 1. Copy board
    # 1.1 Get available spaces and iterate through them
    # 1.2 Place mark on next available space.
    # 1.3 Check for game win or loss
      # If win, return +10
      # If loss, return -10
      # else switch player & repeat 1.1


  def find_best_move(current_board, opponent_marker)
    scores = {}
    current_board.free_spaces.each do |space|
      copied_board = Marshal.load(Marshal.dump(current_board.board))
      board = GameBoard.new(copied_board)
      puts ""
      puts "@@@@@@@@@"
      puts "Space: #{space}"
      puts "Current Board: #{current_board.board}"
      puts "Board: #{board.board}"
      scores[space] = minimax(marker, opponent_marker, space.to_i-1, board, 0)
      puts "Score: #{scores[space]}"
    end
    scores
  end


  def minimax(current_marker, opponent_marker, space, board, depth)
    board.mark_board(current_marker, space)
    if board.check_for_win
      if board.who_won == marker
        puts "----------"
        puts "Player Won"
        puts "Board: #{board.board}"
        puts "Marker: #{marker}"
        puts "Who Won: #{board.who_won}"
        puts "Space: #{space}"
        puts "Depth: #{depth}"
        return 10-depth
      else
        puts "----------"
        puts "Opponent Won"
        puts "Board: #{board.board}"
        puts "Marker: #{marker}"
        puts "Who Won: #{board.who_won}"
        puts "Space: #{space}"
        puts "Depth: #{depth}"
        return -10+depth
      end
    elsif board.check_for_tie
      return 0
    else
      if current_marker == marker
        current_marker = opponent_marker
      else
        current_marker = marker
      end
      depth += 1
      board.free_spaces.each do |space|
        minimax(current_marker, opponent_marker, space.to_i-1, board, depth)
      end
    end
  end


end