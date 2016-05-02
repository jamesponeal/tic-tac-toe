require_relative "../player"
require_relative "../board"

describe "Player" do

  let!(:bob) {Player.new("Bob", "X", "human")}
  let!(:c3po) {Player.new("c3po", "O", "computer")}
  let!(:board1) {GameBoard.new}
  let!(:board2) {GameBoard.new(board_array = ["O", "2", "O", "4", "5", "6", "X", "8", "X"])}
  let!(:board3) {GameBoard.new(board_array = ["X", "2", "3", "4", "O", "6", "7", "8", "9"])}


  describe "Player Creation" do
    it "Creates a player object" do
      expect(bob).to be_a(Player)
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

  describe "#immediate_move" do
    it "Returns an available space on the board that is a winning move" do
      expect(bob.immediate_move(board2, bob.marker)).to eq 7
    end

    it "Returns nil if there is no winning move" do
      expect(bob.immediate_move(board1, bob.marker)).to eq nil
    end
  end

  describe "#opposite_corner_move" do
    it "Returns an available space on the board that is a winning move" do
      expect(bob.opposite_corner_move(board3)).to eq 8
    end
  end

  describe "#find_best_move" do
    it "Returns something" do
      expect(c3po.find_best_move(board2, bob.marker)).to eq({})
    end
  end


end