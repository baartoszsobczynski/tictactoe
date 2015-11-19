class Board
  attr_reader(:fields)

  def initialize
    @fields = Array.new(3) { Array.new(3, nil) }
  end

  def print_board
    puts " 0    1    2"
    puts "0 " + get_mark(0, 0) + "    " + get_mark(0, 1) + "    " + get_mark(0, 2)
    puts
    puts "1 " + get_mark(1, 0) + "    " + get_mark(1, 1) + "    " + get_mark(1, 2)
    puts
    puts "2 " + get_mark(2, 0) + "    " + get_mark(2, 1) + "    " + get_mark(2, 2)
  end

  def get_mark(row, col)
    @fields[row][col].nil? ? "." : @fields[row][col]
  end

  def put_mark(field, mark)
    field = field.split(" ").map {|element| element.to_i }
    valid_range = (0..2)
    if (valid_range === field[0] && valid_range === field[1] && @fields[field[0]][field[1]].nil?)
      @fields[field[0]][field[1]] = mark
      true
    else
      false
    end
  end
end