class Player
  attr_reader :color
  def initialize(color)
    @color = color
  end

  def get_move
    puts "Enter your move (s to save)"
    input = []

    until input.length == 2 || input[0] == 's'  #move by saying   A2 B2
      input = gets.chomp.downcase.split(' ')
    end
    #.map{|num| num.to_i}
    #.map{ |ele| ele.split(',')
    #decode = {}
    return 's' if input[0] == 's'

    hash = {
      'a' => 0,
      'b' => 1,
      'c' => 2,
      'd' => 3,
      'e' => 4,
      'f' => 5,
      'g' => 6,
      'h' => 7,
      '1' => 7,
      '2' => 6,
      '3' => 5,
      '4' => 4,
      '5' => 3,
      '6' => 2,
      '7' => 1,
      '8' => 0
     }
    # move is now ["A2", "B5"]
    move = input.map do |coord|
      coord.split('').map{|char| hash[char]}
    end
    # input is [[x, y], [x, y]]
    move.map{|coord|coord.reverse}
  end
end