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


end