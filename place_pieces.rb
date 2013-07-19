class Board

  def place_initial_pieces
    place_rooks
    place_knights
    place_bishops
    place_queens
    place_kings
    place_pawns
  end

  def place_rooks
    hash = {
      :board => self,
      :coord => [0, 0],
      :color => :b
    }

    y,x = hash[:coord]
    @board[y][x] = Rook.new(hash)

    hash[:coord] = [0, 7]
    y,x = hash[:coord]
    @board[y][x] = Rook.new(hash)

    #change color

    hash[:color] = :w

    hash[:coord] = [7, 0]
    y,x = hash[:coord]
    @board[y][x] = Rook.new(hash)

    hash[:coord] = [7, 7]
    y,x = hash[:coord]
    @board[y][x] = Rook.new(hash)
  end

  def place_knights
    hash = {
      :board => self,
      :coord => [0, 1],
      :color => :b
    }

    y,x = hash[:coord]
    @board[y][x] = Knight.new(hash)

    hash[:coord] = [0, 6]
    y,x = hash[:coord]
    @board[y][x] = Knight.new(hash)

    #change color

    hash[:color] = :w

    hash[:coord] = [7, 1]
    y,x = hash[:coord]
    @board[y][x] = Knight.new(hash)

    hash[:coord] = [7, 6]
    y,x = hash[:coord]
    @board[y][x] = Knight.new(hash)
  end

  def place_bishops
    hash = {
      :board => self,
      :coord => [0, 2],
      :color =>:b
    }

    y,x = hash[:coord]
    @board[y][x] = Bishop.new(hash)

    hash[:coord] = [0, 5]
    y,x = hash[:coord]
    @board[y][x] = Bishop.new(hash)

    #change color

    hash[:color] = :w

    hash[:coord] = [7, 2]
    y,x = hash[:coord]
    @board[y][x] = Bishop.new(hash)

    hash[:coord] = [7, 5]
    y,x = hash[:coord]
    @board[y][x] = Bishop.new(hash)
  end

  def place_queens
    hash = {
      :board => self,
      :coord => [0, 3],
      :color => :b
    }

    y,x = hash[:coord]
    @board[y][x] = Queen.new(hash)

    #change color

    hash[:color] = :w

    hash[:coord] = [7, 3]
    y,x = hash[:coord]
    @board[y][x] = Queen.new(hash)
  end

  def place_kings
    hash = {
      :board => self,
      :coord => [0, 4],
      :color => :b
    }

    y,x = hash[:coord]
    @board[y][x] = King.new(hash)
    @black_king_space = hash[:coord]

    #change color

    hash[:color] = :w

    hash[:coord] = [7, 4]
    y,x = hash[:coord]
    @board[y][x] = King.new(hash)
    @white_king_space = hash[:coord]
  end

  def place_pawns
    hash = {
      :board => self,
      :color => :b
    }

    8.times do |x|
      hash[:coord] = [1, x]
      y,x = hash[:coord]
      @board[y][x] = Pawn.new(hash)
    end

    #change color

    hash[:color] = :w
    8.times do |x|

      hash[:coord] = [6, x]
      y,x = hash[:coord]
      @board[y][x] = Pawn.new(hash)
    end

  end

end