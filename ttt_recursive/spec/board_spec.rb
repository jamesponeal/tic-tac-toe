require_relative "../board"

describe "Board" do

  let!(:board1) {GameBoard.new}
  let!(:board2) {GameBoard.new(board_array = ["O", "2", "O", "4", "X", "6", "X", "8", "9"])}
  # O 2 O
  # 4 X 6
  # X 8 9
  let!(:board3) {GameBoard.new(board_array = ["O", "2", "3", "4", "X", "6", "7", "8", "9"])}
  # O 2 3
  # 4 X 6
  # 7 8 9
  let!(:won_board) {GameBoard.new(board_array = ["O", "O", "O", "4", "X", "6", "X", "8", "9"])}
  # O O O
  # 4 X 6
  # X 8 9
  let!(:tie_board) {GameBoard.new(board_array = ["O", "X", "O", "O", "X", "O", "X", "O", "X"])}
  # O X O
  # O X O
  # X O X
  let!(:almost_board1) {GameBoard.new(board_array = ["O", "X", "O", "X", "X", "O", "O", "8", "9"])}
  # O X O
  # X X O
  # O 8 9
  let!(:almost_board2) {GameBoard.new(board_array = ["O", "2", "3", "X", "5", "X", "O", "8", "9"])}
  # O 2 3
  # X 5 X
  # O 8 9

  describe "Board Creation" do
    it "Creates a board object" do
      expect(board1).to be_a(GameBoard)
    end

    it "Creates a board object" do
      expect(board2).to be_a(GameBoard)
    end

    it "Creates a board object" do
      expect(won_board).to be_a(GameBoard)
    end
  end

  describe "#free_spaces" do
    it "returns array of available spaces" do
      expect(board1.free_spaces).to eq(["1", "2", "3", "4", "5", "6", "7", "8", "9"])
    end

    it "returns array of empty spaces" do
      expect(board2.free_spaces).to eq(["2", "4", "6", "8", "9"])
    end

    it "returns array of empty spaces" do
      expect(tie_board.free_spaces).to eq([])
    end
  end

  # describe "#free_corner_spaces" do
  #   it "returns array of empty corner spaces" do
  #     expect(board1.free_corner_spaces).to eq(["1", "3", "7", "9"])
  #   end

  #   it "returns array of empty corner spaces" do
  #     expect(board2.free_corner_spaces).to eq(["9"])
  #   end

  #   it "returns array of empty corner spaces" do
  #     expect(tie_board.free_corner_spaces).to eq([])
  #   end
  # end

  # describe "#free_side_spaces" do
  #   it "returns array of empty side spaces" do
  #     expect(board1.free_side_spaces).to eq(["2", "4", "6", "8"])
  #   end

  #   it "returns array of empty side spaces" do
  #     expect(won_board.free_side_spaces).to eq(["4", "6", "8"])
  #   end

  #   it "returns array of empty side spaces" do
  #     expect(tie_board.free_side_spaces).to eq([])
  #   end
  # end

  describe "#valid_choice?" do
    it "returns true if the choice is available" do
      expect(board1.valid_choice?(5)).to be true
    end

    it "returns false if the choice is not available" do
      expect(board2.valid_choice?(5)).to be false
    end

    it "returns false if the choice is not valid" do
      expect(board2.valid_choice?(10)).to be false
    end
  end

  describe "#check_for_win" do
    it "Returns false if board is not in a win condition" do
      expect(board1.check_for_win).to be false
    end

    it "Returns true if board is in a win condition" do
      expect(won_board.check_for_win).to be true
    end
  end

  describe "#check_for_tie" do
    it "Returns false if board is not in a tie condition" do
      expect(board1.check_for_tie).to be false
    end

    it "Returns true if board is in a tie condition" do
      expect(tie_board.check_for_tie).to be true
    end
  end

  describe "#mark_board" do
    it "Marks the board with a marker in the chosen spot" do
      board1.mark_board("X", 4)
      expect(board1.board).to eq ["1", "2", "3", "4", "X", "6", "7", "8", "9"]
    end
  end

  describe "#copy_board" do
    it "creates a copy of current board" do
      expect((won_board.copy_board).board).to eq ["O", "O", "O", "4", "X", "6", "X", "8", "9"]
    end

    it "creates a copy of current board" do
      expect((board2.copy_board).board).to eq ["O", "2", "O", "4", "X", "6", "X", "8", "9"]
    end

    it "creates a copy of current board" do
      expect((board2.copy_board).board).not_to eq ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
    end

    it "creates copied board with different object id" do
      copied_board = won_board.copy_board
      expect(copied_board.object_id).not_to eq(won_board.object_id)
      expect(won_board.object_id).to eq(won_board.object_id)
    end
  end

  describe "#who_won" do
    it "returns the winner marker" do
      expect(won_board.who_won).to eq("O")
    end

    it "returns nil if there is no winner" do
      expect(board1.who_won).to be nil
    end
  end

  describe "score_move" do
    it "returns score of a board with a winning condition" do
      expect(won_board.score_move("O", 0)).to eq 10
    end

    it "returns score of a board with a winning condition" do
      expect(won_board.score_move("O", 1)).to eq 9
    end

    it "returns score of a board with a winning condition" do
      expect(won_board.score_move("X", 2)).to eq -8
    end
  end

  describe "switch_marker" do
    it "switches the current marker and returns it" do
      expect(board1.switch_marker("X","O","X")).to eq("O")
    end

    it "switches the current marker and returns it" do
      expect(board1.switch_marker("X","O","O")).to eq("X")
    end
  end

  describe "get_score" do
    it "returns positive score of a board with an imminent win when correct choice is made" do
      expect(almost_board1.get_score("X","O","X",7,0)).to eq 10
    end

    it "returns tie score of a board with an imminent win when incorrect choice is made" do
      expect(almost_board1.get_score("X","O","X",8,0)).to eq 0
    end

    it "returns positive score of a board with an imminent win when correct choice is made with depth" do
      expect(almost_board1.get_score("X","O","X",7,1)).to eq 9
    end

    it "returns score of a board with an imminent loss" do
      expect(almost_board1.get_score("X","O","O",8,0)).to eq -10
    end

    it "returns score on a move on partially complete board" do
      expect(almost_board2.get_score("O","X","O",4)).to eq -9
    end
  end

end