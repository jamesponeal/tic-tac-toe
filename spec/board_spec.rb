require_relative "../board"

describe "Board" do

  let!(:board1) {GameBoard.new}
  let!(:board2) {GameBoard.new(board_array = ["O", "2", "O", "4", "X", "6", "X", "8", "9"])}
  let!(:board3) {GameBoard.new(board_array = ["O", "2", "3", "4", "X", "6", "7", "8", "9"])}
  let!(:won_board) {GameBoard.new(board_array = ["O", "O", "O", "4", "X", "6", "X", "8", "9"])}
  let!(:tie_board) {GameBoard.new(board_array = ["O", "X", "O", "O", "X", "O", "X", "O", "X"])}

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

  describe "#free_corner_spaces" do
    it "returns array of empty corner spaces" do
      expect(board1.free_corner_spaces).to eq(["1", "3", "7", "9"])
    end

    it "returns array of empty corner spaces" do
      expect(board2.free_corner_spaces).to eq(["9"])
    end

    it "returns array of empty corner spaces" do
      expect(tie_board.free_corner_spaces).to eq([])
    end
  end

  describe "#free_side_spaces" do
    it "returns array of empty side spaces" do
      expect(board1.free_side_spaces).to eq(["2", "4", "6", "8"])
    end

    it "returns array of empty side spaces" do
      expect(won_board.free_side_spaces).to eq(["4", "6", "8"])
    end

    it "returns array of empty side spaces" do
      expect(tie_board.free_side_spaces).to eq([])
    end
  end

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


end