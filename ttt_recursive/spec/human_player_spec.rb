require_relative "../player"
require_relative "../human_player"
require_relative "../computer_player"
require_relative "../board"

describe "HumanPlayer" do

  let!(:bob) {HumanPlayer.new("Bob", "X", "human")}
  let!(:board1) {GameBoard.new}
  let!(:board2) {GameBoard.new(board_array = ["O", "2", "O", "4", "5", "6", "X", "8", "X"])}
  let!(:board3) {GameBoard.new(board_array = ["X", "2", "3", "4", "O", "6", "7", "8", "9"])}


  describe "Player Creation" do
    it "Creates a human player object" do
      expect(bob).to be_a(HumanPlayer)
    end
  end

  describe "Player parameters" do
    it "Creates player object with a name" do
      expect(bob.name).to eq "Bob"
    end

    it "Creates player object with a marker" do
      expect(bob.marker).to eq "X"
    end

    it "Creates player object with a type" do
      expect(bob.type).to eq "human"
    end
  end






end