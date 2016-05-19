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


  # describe "select_best_move" do
  #   it "selects best move from a hash of scored moves" do
  #     expect(c3po.select_best_move({"8"=>0, "9"=>10})).to eq(8)
  #   end

  #   it "selects best move from a hash of scored moves" do
  #     expect(c3po.select_best_move({"4"=>-9, "5"=>-7, "6"=>-9, "7"=>-9, "9"=>-9})).to eq(4)
  #   end
  # end


  # get_score(board, opponent_marker, current_marker, space, depth = 0)
  describe "get_score" do

    # board: almost_won, space 8("9") should be best move
    it "" do
      expect(c3po.get_score(almost_won,"X",c3po.marker,8,0)).to eq 10
    end

    it "" do
      expect(c3po.get_score(almost_won,"X",c3po.marker,7,0)).to eq -9
    end


    # board: almost_won2, space 5("6") should be best move
    it "" do
      expect(c3po.get_score(almost_won2,"X",c3po.marker,1,0)).to eq -9
    end

    it "" do
      expect(c3po.get_score(almost_won2,"X",c3po.marker,2,0)).to eq -9
    end

    it "" do
      expect(c3po.get_score(almost_won2,"X",c3po.marker,5,0)).to eq 0
    end

    it "" do
      expect(c3po.get_score(almost_won2,"X",c3po.marker,6,0)).to eq -9
    end

    it "" do
      expect(c3po.get_score(almost_won2,"X",c3po.marker,7,0)).to eq -9
    end


    # board: board 1
    it "" do
      expect(c3po.get_score(board1,"X",c3po.marker,0,0)).to eq -17
    end

    it "" do
      expect(c3po.get_score(board1,"X",c3po.marker,4,0)).to eq -17
    end


    # board3:

    # it "" do
    #   expect(c3po.get_score(board3,"X",c3po.marker,1,0)).to eq 1
    # end

    # it "" do
    #   expect(c3po.get_score(board3,"X",c3po.marker,2,0)).to eq 1
    # end

    # it "" do
    #   expect(c3po.get_score(board3,"X",c3po.marker,3,0)).to eq 1
    # end

    # it "" do
    #   expect(c3po.get_score(board3,"X",c3po.marker,5,0)).to eq 1
    # end

    # it "" do
    #   expect(c3po.get_score(board3,"X",c3po.marker,6,0)).to eq 1
    # end

    # it "" do
    #   expect(c3po.get_score(board3,"X",c3po.marker,7,0)).to eq 1
    # end

    # it "" do
    #   expect(c3po.get_score(board3,"X",c3po.marker,8,0)).to eq 1
    # end
  end

  # score_available_moves(board, opponent_marker, current_marker, depth = 0)
  describe "score_available_moves" do
    # it "returns scores" do
    #   expect(c3po.score_available_moves(almost_won2,"X",c3po.marker,0)).to eq -9
    # end

    # it "returns scores" do
    #   expect(c3po.score_available_moves(board1,"X",c3po.marker,0)).to eq 0
    # end

    # it "returns scores" do
    #   expect(c3po.score_available_moves(almost_board2, "X")).to eq {"4"=>-9, "5"=>-7, "6"=>-9, "7"=>-9, "9"=>-9}
    # end

    # it "returns scores" do
    #   expect(c3po.score_available_moves(board1, "X")).to eq "1"
    # end
  end

  describe "get_best_move" do
    # it "returns best move" do
    #   expect(c3po.get_best_move(board3,"X")).to eq 1
    # end

    # it "returns best move" do
    #   expect(c3po.get_best_move(board1,"X")).to eq 0
    # end

  end


end