require_relative "player"

class ComputerPlayer < Player

  def initialize(name = nil, marker = nil, type = "computer")
    super(name, marker, type)
  end


  def switch_marker(opponent_marker, current_marker)
    current_marker == marker ? opponent_marker : marker
  end

  def best_move(next_marker, opponent_marker, scores)
    if next_marker == opponent_marker
      return scores.min_by{|k,v| v}[1]
    else
      return scores.max_by{|k,v| v}[1]
    end
  end


  #gets score of an individual move
  def get_score(board, opponent_marker, current_marker, space, depth = 0)
    board.mark_board(current_marker, space)
    if board.check_for_win
      return board.score_move(marker, depth)
    elsif board.check_for_tie
      return 0
    else
      depth += 1
      next_marker = switch_marker(opponent_marker, current_marker)
      scores = score_available_moves(board, opponent_marker, next_marker, depth)
      return best_move(next_marker, opponent_marker, scores)
    end
  end

  #returns hash of moves and scores. key: space, value: score
  def score_available_moves(board, opponent_marker, current_marker, depth = 0)
    scores = {}
    board.free_spaces.each do |space|
      copied_board = board.copy_board
      score = get_score(copied_board, opponent_marker, current_marker, space.to_i-1, depth)
      scores[space] = score
    end
    return scores
  end

  def get_best_move(board, opponent_marker)
    copied_board = board.copy_board
    scores = score_available_moves(copied_board, opponent_marker, marker)
    best_move = scores.max_by{|k,v| v}[0]
    return best_move.to_i-1
  end


end