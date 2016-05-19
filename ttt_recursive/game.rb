require_relative 'game_setup'
require_relative 'game_view'
require_relative 'game_controller'

game = GameController.new
game.print_title
game.game_setup
game.play_game

