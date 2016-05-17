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

  describe "score_available_moves" do
    it "returns scores" do
      expect(c3po.score_available_moves(board2, "X")).to eq 0
    end
  end


end