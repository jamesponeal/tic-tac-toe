require_relative "../player"
require_relative "../computer_player"
require_relative "../board"

describe "ComputerPlayer" do

  let!(:c3po) {ComputerPlayer.new("c3po", "O", "computer")}
  let!(:board1) {GameBoard.new}
  let!(:board2) {GameBoard.new(board_array = ["O", "2", "O", "4", "5", "6", "X", "8", "X"])}
  # O 2 O
  # 4 5 6
  # X 8 X
  let!(:board3) {GameBoard.new(board_array = ["X", "2", "3", "4", "O", "6", "7", "8", "9"])}
  # X 2 3
  # 4 O 6
  # 7 8 9
  let!(:almost_won) {GameBoard.new(board_array = ["X", "X", "O", "X", "X", "O", "O", "8", "9"])}
  # X X O
  # X X O
  # O 8 9
  let!(:almost_won2) {GameBoard.new(board_array = ["O", "2", "3", "X", "X", "6", "7", "8", "O"])}
  # O 2 3
  # X X 6
  # 7 8 O
  let!(:almost_tie) {GameBoard.new(board_array = ["O", "X", "O", "X", "X", "O", "O", "8", "X"])}
  # O X O
  # X X O
  # O 8 X


  describe "Player Creation" do
    it "Creates a computer player object" do
      expect(c3po).to be_a(ComputerPlayer)
    end
  end

  describe "Player parameters" do
    it "Creates player object with a name" do
      expect(c3po.name).to eq "c3po"
    end

    it "Creates player object with a marker" do
      expect(c3po.marker).to eq "O"
    end

    it "Creates player object with a type" do
      expect(c3po.type).to eq "computer"
    end
  end


  describe "switch_marker" do
    it "switches the current marker and returns it" do
      expect(c3po.switch_marker("X","O")).to eq("X")
    end

    it "switches the current marker and returns it" do
      expect(c3po.switch_marker("X","X")).to eq("O")
    end
  end


  # get_score(board, opponent_marker, current_marker, space, depth = 0)
  describe "get_score" do
    it "returns 10 when choosing a winning move" do
      expect(c3po.get_score(almost_won,"X",c3po.marker,8,0)).to eq 10
    end

    it "returns -9 when choosing a move that results in a loss on opponents move" do
      expect(c3po.get_score(almost_won,"X",c3po.marker,7,0)).to eq -9
    end
  end

  describe "get_best_move" do
    it "returns best move as side space when player is in middle and opponent is corner" do
      expect(c3po.get_best_move(board3,"X")).to eq 1
    end

    it "returns best move as corner on a new board" do
      expect(c3po.get_best_move(board1,"X")).to eq 0
    end

    it "returns best move as a winning move" do
      expect(c3po.get_best_move(almost_won,"X")).to eq 8
    end

    it "returns best move as a blocking move" do
      expect(c3po.get_best_move(almost_won2,"X")).to eq 5
    end
  end

end