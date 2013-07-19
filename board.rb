require './pieces'
require 'debugger'
require 'colorize'
class Board
  attr_reader :board, :white_king_space, :black_king_space
  def initialize
    @board = create_matrix

  end

  def create_matrix
    matrix = Array.new(8){Array.new(8){nil}}
  end


  def display_board
    @board.each_index do |y|
      print "#{(9-y-1).to_i}| "
      @board[y].each_index do |x|
        string = @board[y][x].nil? ? ' ' : @board[y][x].symbol
        color = nil
        color = @board[y][x].symbol_color unless @board[y][x].nil?
        string += " "

        if (y + x).even?
          print string.colorize(:color => color, :background => :black)
        else
          print string.colorize(:color => color, :background => :red)
        end

        # print @board[y][x].symbol unless @board[y][x].nil?
        # print "_" if @board[y][x].nil?
        # print ' '
      end

      print "\n"
    end
    print "   A B C D E F G H\n"

    nil
  end

  def piece_at(coord)
    y,x = coord
    return nil if !y.between?(0,7) || !x.between?(0,7)
    return @board[y][x]
  end

  def legal_move?(coords, color)
    piece = piece_at(coords[0])

    # end_piece = piece_at(coords[1])
    # return false if end_piece and end_piece.color == color
    y1,x1 = coords[0]
    y2, x2 = coords[1]

    return false if !y1.between?(0,7) || !x1.between?(0,7) || !y2.between?(0,7) || !x2.between?(0,7)
    return false if piece.nil? || piece.color != color


    return false if !piece.valid_move?(coords) or !valid_check_move?(coords,color)

    return true

  end

  def valid_check_move?(coords,color)
    dupe_board = Marshal.load(Marshal.dump(self))
    dupe_board.move_piece(coords,color)
    return false if dupe_board.check? == color
    return true
  end

  def move_piece(coords, color)
    y1,x1 = coords[0]
    y2,x2 = coords[1]
    piece = piece_at([y1,x1])
    @board[y1][x1] = nil
    @board[y2][x2] = piece
    piece.coord = [y2,x2]

    if piece.is_a?(King)
      if color == :w
        @white_king_space = [y2,x2]
      else
        @black_king_space = [y2,x2]
      end
    end
  end

  def check_mate?(color)
    8.times do |y|
      8.times do |x|
        dupe_board = Marshal.load(Marshal.dump(self))
        piece = dupe_board.piece_at([y,x])

        unless piece.nil? || piece.color == color
          piece.possible_moves.each do |move|

            second_dupe = Marshal.load(Marshal.dump(dupe_board))

            next unless second_dupe.legal_move?([piece.coord, move], piece.color)
            second_dupe.move_piece([piece.coord, move], piece.color)
            if second_dupe.check?.nil?
              return false
            end
          end
        end
      end
    end
    return true
  end



  def check?
    8.times do |y|
      8.times do |x|
        piece = piece_at([y,x])
        next if piece.nil?
        return :w if piece.possible_moves.include?(@white_king_space)
        return :b if piece.possible_moves.include?(@black_king_space)
      end
    end
    nil
  end




  #checks to make sure spaces between start and finish are open
  def open_path?(start,finish)
    start_piece = piece_at(start)
    end_piece = piece_at(finish)
    #debugger
    return false if end_piece and end_piece.color == start_piece.color

    sy, sx = start
    fy, fx = finish
    #check horizontals
    if sy == fy
      minx = [sx,fx].min
      maxx = [sx,fx].max
      ((minx + 1)...maxx).each do |new_x|
        return false if !@board[sy][new_x].nil?
      end
    end

    #check verticals
    if sx == fx
      miny = [sy,fy].min
      maxy = [sy,fy].max
      ((miny + 1)...maxy).each do |new_y|
        return false if !@board[new_y][sx].nil?
      end
    end

    #check diags
    if (sx - fx).abs == (sy - fy).abs
      miny = [sy,fy].min
      maxy = [sy,fy].max
      #down right
      if ((sx < fx) == (sy < fy))
        new_x = [sx,fx].min
        ((miny+1)...maxy).each_with_index do |new_y, d|
          return false if !@board[new_y][new_x + d + 1].nil?
        end
      #down left
      else
        new_x = [sx,fx].max
        ((miny+1)...maxy).each_with_index do |new_y, d|
        return false if  !@board[new_y][new_x - d - 1].nil?
        end
      end
    end
    true
  end


end

if $PROGRAM_NAME == __FILE__
  b = Board.new
  b.place_initial_pieces
  b.display_board
end