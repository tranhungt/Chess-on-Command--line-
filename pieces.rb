#encoding: utf-8
require 'colorize'

class Piece
  attr_accessor :symbol, :color, :coord
  def initialize(hash)
    @color = hash[:color]
    @board = hash[:board]
    @coord = hash[:coord]
    @y, @x = @coord
  end

  def coord=(coord)
    @coord = coord
    @y, @x = @coord
  end

  def symbol_color
    if color == :w
      return :white
    else
      return :yellow
    end
  end

  def valid_move?(coords)
    return true if possible_moves.include?(coords[1])
    false
  end

  def narrow_moves(moves)
    moves.select do |move|
      @board.open_path?(@coord, move)
    end
  end

  def get_horizontals
    array = []
    y,x = @coord
    8.times do |new_x|
      array << [y,new_x] unless new_x == x
    end
    array
  end

  def get_verticals
    array = []
    y,x = @coord
    8.times do |new_y|
      array << [new_y,x] unless new_y == y
    end
    array

  end

  def get_diags
    array = []
    y,x = @coord
    # down right diag
    (-10..10).each do |d|
      dy = y + d
      dx = x + d
      unless (dy == y && dx == x) || !dy.between?(0,7) || !dx.between?(0,7)
        array << [dy, dx]
      end
    end

    #down left diag
    (-10..10).each do |d|
      dy = y + d
      dx = x - d
      unless (dy == y && dx == x) || !dy.between?(0,7) || !dx.between?(0,7)
        array << [dy, dx]
      end
    end
    array

  end

end
######################
class Pawn < Piece

  def initialize(hash)
    super(hash)

    @symbol = make_symbol
  end

  def make_symbol
    return "♟"

    return "♙" if @color == :w
    "♟" if @color == :b
  end
end
################
class Rook < Piece

  def initialize(hash)
    super(hash)

    @symbol = make_symbol
  end

  def make_symbol
    return "♜"
    return "♖" if @color == :w
    "♜" if @color == :b
  end
end
######################
class Knight < Piece

  def initialize(hash)
    super(hash)

    @symbol = make_symbol
  end

  def make_symbol
    return "♞"
    return "♘" if @color == :w
    "♞" if @color == :b
  end
end
#########################
class Bishop < Piece

  def initialize(hash)
    super(hash)

    @symbol = make_symbol
  end

  def make_symbol
    return "♝"
    return "♗" if @color == :w
    "♝" if @color == :b
  end
end
#########################
class King < Piece

  def initialize(hash)
    super(hash)

    @symbol = make_symbol
  end

  def make_symbol
    return "♚"
    return "♔" if @color == :w
    "♚" if @color == :b
  end

end
###########################
class Queen < Piece

  def initialize(hash)
    super(hash)

    @symbol = make_symbol
  end

  def make_symbol
    return "♛"
    return "♕" if @color == :w
    "♛" if @color == :b
  end

end