require_relative "../player"

describe "Player" do

  let!(:bob) {Player.new("Bob", "X", "human")}


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
      expect(board2.immediate_move("O")).to eq 1
    end

    it "Returns nil if there is no winning move" do
      expect(board1.immediate_move("O")).to eq nil
    end
  end

  describe "#opposite_corner_move" do
    it "Returns an available space on the board that is a winning move" do
      expect(board3.opposite_corner_move("O")).to eq 8
    end
  end


end