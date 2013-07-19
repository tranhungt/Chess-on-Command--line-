require './board'
require './human_player'
require './pieces'
require './place_pieces'
require './piece_moves'

class Game

  def initialize
    @board = Board.new
    @players = [Player.new(:w), Player.new(:b)]
    @turn = 0
  end

  def start
    puts "Load saved game? y/n"
    option = gets.chomp
    if option == 'y'
      load_game
    else
      new_game
    end
  end

  def play


    @board.display_board

    check_mate = false
    until false || check_mate
      current_player = @players[@turn]
      puts "#{current_player.color}'s move"
      move = current_player.get_move
      if move == 's'
        save_game
        break
      end
      until @board.legal_move?(move, current_player.color)# && check == false
        puts "#{current_player.color}'s move"
        move = current_player.get_move
      end
      @board.move_piece(move, current_player.color)
      @board.display_board
      #check_color = current_player.color == :w ? :b : :w

      if @board.check?
        if @board.check_mate?(current_player.color)
          puts "CHECK_MATE"
          check_mate = true
        else
          puts "Check!!!"
        end
        #check = true
      end
      @turn = @turn == 0 ? 1 : 0
    end
  end

  def save_game
    File.open('chess.yaml', 'w'){ |f| f.puts [@board,@turn].to_yaml }
    puts "Game is SAVED"
  end

  def new_game
    @board.place_initial_pieces
    play
  end

  def load_game
    f = File.read("chess.yaml")
    @board, @turn = YAML::load(f)
    play


  end

end

g = Game.new
g.start

