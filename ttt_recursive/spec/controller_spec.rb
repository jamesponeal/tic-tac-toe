require_relative '../game_controller'
require_relative '../board'
require_relative '../player'


describe "GameController" do

  let!(:won_board) {GameBoard.new(board_array = ["O", "O", "O", "4", "X", "6", "X", "8", "9"])}
  let!(:tie_board) {GameBoard.new(board_array = ["O", "X", "O", "O", "X", "O", "X", "O", "X"])}
  let!(:game1) {GameController.new}
  let!(:won_game) {GameController.new(won_board)}
  let!(:tie_game) {GameController.new(tie_board)}
  let!(:bob) {Player.new("Bob", "O", "human")}

  describe "Game Creation" do
    it "Creates a GameController object" do
      expect(game1).to be_a(GameController)
    end

    it "Creates a GameController object" do
      expect(won_game).to be_a(GameController)
    end

    it "Creates a GameController object" do
      expect(tie_game).to be_a(GameController)
    end
  end

  describe "#get_game_type" do
    it "Returns game type selection" do
      expect(game1.get_game_type("1")).to eq("1")
    end
  end

  describe "#get_first_move_choice" do
    it "Returns first move choice" do
      expect(game1.get_first_move_choice("1")).to eq("1")
    end
  end

  describe "#check_for_game_over" do
    it "Sets game_over to true and winner to tie" do
      tie_game.check_for_game_over(bob)
      expect(tie_game.game_over).to be true
      expect(tie_game.winner).to eq "tie"
    end

    it "Sets game_over to true and winner to player" do
      won_game.check_for_game_over(bob)
      expect(won_game.game_over).to be true
      expect(won_game.winner).to be bob
    end
  end

end
