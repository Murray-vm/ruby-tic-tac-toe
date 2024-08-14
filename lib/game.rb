require_relative "player"
# Class to play a single round of tic tac toe
class Game
  WINNING_LINES = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]].freeze

  attr_accessor :board, :player1, :player2

  def initialize
    @player1 = Player.new("Player 1", "X")
    @player2 = Player.new("Player 2", "O")
    @board = [0, 1, 2, 3, 4, 5, 6, 7, 8]
  end

  def display_board
    puts "+---+---+---+"
    (0..2).each do |i|
      line = "|"
      (0..2).each do |j|
        index = (i * 3) + j
        line.concat(" #{board[index]} |")
      end
      puts line
      puts "+---+---+---+"
    end
  end

  def check_move(move)
    if move.between?(0, 8) && board[move].is_a?(Integer)
      true
    else
      puts "Invalid move. Please select one of the available blocks."
      false
    end
  end

  def play_turn(player)
    puts "#{player.name}'s turn: #{player.symbol}"
    display_board

    loop do
      print "Select a grid number to play your turn: "
      move = gets.to_i

      next unless check_move(move)

      player.save_move(move)
      board[move] = player.symbol
      break
    end
  end

  def won?(player)
    has_won = false
    WINNING_LINES.each do |win_line|
      next unless (win_line - player.moves).empty?

      puts "#{player.name} has won the game"
      display_board
      has_won = true
      break
    end
    has_won
  end

  def tie
    is_tie = (board.filter { |block| block.is_a?(Integer) }).empty?
    if is_tie
      puts "Game is a tie"
      display_board
    end
    is_tie
  end

  def start_game
    game_end = false
    players = [player1, player2]

    until game_end
      players.each do |player|
        play_turn(player)
        game_end = won?(player) || tie
        break if game_end
      end
    end
  end
end
