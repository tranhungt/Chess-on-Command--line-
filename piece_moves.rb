require './pieces'

class Pawn

  def possible_moves
    return black_moves if @color == :b
    return white_moves if @color == :w
  end

  def black_moves
    moves = []
    moves << [3, @x] if (@y == 1 && @board.piece_at([3,@x]).nil?)
    moves << [@y + 1, @x]

    moves = narrow_moves(moves)

    right_diag = [@y + 1, @x + 1]
    right_diag_piece = @board.piece_at(right_diag)
    if !right_diag_piece.nil? and right_diag_piece.color == :w
      moves << right_diag
    end

    left_diag = [@y + 1, @x - 1]
    left_diag_piece = @board.piece_at(left_diag)
    if !left_diag_piece.nil? and left_diag_piece.color == :w
      moves << left_diag
    end
    moves
  end

  def white_moves
    moves = []
    moves << [4, @x] if (@y == 6 && @board.piece_at([4,@x]).nil?)
    moves << [@y - 1, @x]

    moves = narrow_moves(moves)

    right_diag = [@y - 1, @x + 1]
    right_diag_piece = @board.piece_at(right_diag)
    if !right_diag_piece.nil? and right_diag_piece.color == :b
      moves << right_diag
    end
    left_diag = [@y - 1, @x - 1]
    left_diag_piece = @board.piece_at(left_diag)
    if !left_diag_piece.nil? and left_diag_piece.color == :b
      moves << left_diag
    end
    moves
  end
end

class Knight

  def possible_moves
    moves = []
    changes = [
    [2 , 1],
    [2 , -1],
    [-2 , 1],
    [-2 , -1],
    [-1 , 2],
    [-1 , -2],
    [1 , -2],
    [1 , 2]
    ]
    changes.each do |change|
      dy, dx = change
      new_y = @y + dy
      new_x = @x + dx
      moves << [new_y, new_x]
    end
    moves
  end

end

class Rook

  def possible_moves
    moves = []
    moves += get_horizontals
    moves += get_verticals
    moves = narrow_moves(moves)
  end

end

class Bishop

  def possible_moves
    moves = []
    moves += get_diags
    moves = narrow_moves(moves)
  end

end

class Queen

  def possible_moves
    moves = []
    moves += get_horizontals
    moves += get_verticals
    moves += get_diags
    moves = narrow_moves(moves)
  end

end

class King
  #for check_mate, these possible moves are not filtered for nil
  def possible_moves
    moves = []
    (-1..1).each do |dy|
      (-1..1).each do |dx|
        new_y = @y + dy
        new_x = @x + dx
        #debugger
        test_piece = @board.piece_at([new_y,new_x])
        moves << [new_y, new_x] unless ((new_x == @x && new_y == @y) || test_piece.nil?)
      end
    end
    moves = narrow_moves(moves)
  end

end
