require_relative '../game_controller'
require_relative '../board'
require_relative '../player'


def ignore_puts
   before do
    allow($stdout).to receive(:puts)
   end
end


describe "GameController" do

  let!(:bob) {HumanPlayer.new("Bob", "X")}
  let!(:c3po) {ComputerPlayer.new("C3PO", "O")}
  let!(:board1) {GameBoard.new}
  let!(:board2) {GameBoard.new(board_array = ["X", "2", "3", "4", "5", "6", "7", "8", "9"])}
  let!(:board21) {GameBoard.new(board_array = ["1", "X", "3", "4", "5", "6", "7", "8", "9"])}
  let!(:board3) {GameBoard.new(board_array = ["O", "2", "3", "4", "X", "6", "7", "8", "9"])}
  let!(:board31) {GameBoard.new(board_array = ["O", "2", "3", "X", "5", "6", "7", "8", "9"])}
  let!(:board32) {GameBoard.new(board_array = ["X", "2", "3", "4", "O", "X", "7", "8", "O"])}
  let!(:board4) {GameBoard.new(board_array = ["X", "2", "3", "4", "O", "6", "7", "8", "X"])}
  let!(:board41) {GameBoard.new(board_array = ["O", "X", "3", "4", "5", "6", "7", "8", "X"])}
  let!(:board42) {GameBoard.new(board_array = ["X", "2", "3", "4", "O", "6", "7", "X", "O"])}
  let!(:won_board) {GameBoard.new(board_array = ["O", "O", "O", "4", "X", "6", "X", "8", "9"])}
  let!(:tie_board) {GameBoard.new(board_array = ["O", "X", "O", "O", "X", "O", "X", "O", "X"])}
  let!(:game1) {GameController.new(board1)}
  let!(:game2) {GameController.new(board2)}
  let!(:game21) {GameController.new(board21)}
  let!(:game3) {GameController.new(board3)}
  let!(:game31) {GameController.new(board31)}
  let!(:game32) {GameController.new(board32)}
  let!(:game4) {GameController.new(board4)}
  let!(:game41) {GameController.new(board41)}
  let!(:game42) {GameController.new(board42)}
  let!(:won_game) {GameController.new(won_board)}
  let!(:tie_game) {GameController.new(tie_board)}


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

  describe "#play_turn" do
    ignore_puts

    it "Computer places first move in a random corner on a new board" do
      game1.current_player = c3po
      game1.p1 = c3po
      game1.other_player = bob
      game1.p2 = bob
      game1.play_turn
      expect(board1.board).to eq(["O", "2", "3", "4", "5", "6", "7", "8", "9"]).or eq(["1", "2", "O", "4", "5", "6", "7", "8", "9"]).or eq(["1", "2", "3", "4", "5", "6", "O", "8", "9"]).or eq(["1", "2", "3", "4", "5", "6", "7", "8", "O"])
    end

    it "Computer places first move in center if opponent moved corner" do
      game2.current_player = c3po
      game2.p1 = c3po
      game2.other_player = bob
      game2.p2 = bob
      game2.play_turn
      expect(board2.board).to eq(["X", "2", "3", "4", "O", "6", "7", "8", "9"])
    end
  end

end
