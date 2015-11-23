require './player.rb'
require './board.rb'

class Game
  def initialize
    puts "Welcome to TicTacToe. Have fun!"
    @is_ended = false
    @players = load_players
    @board = Board.new
  end

  def load_players
    players = Array.new
    puts "First player name:"
    players[0] = Player.new(gets.chomp, "X")
    puts "Second player name:"
    players[1] = Player.new(gets.chomp, "O")
    players
  end

  def start
    draw_and_set_starting_player
    until @is_ended
      begin
       ask_for_turn(current_player)
      rescue
        puts "Something went wrong! Try again"
      end
      switch_players
    end
  end

  def draw_and_set_starting_player
    switch_players if rand > 0.5
    puts "#{current_player.name} will start the game!"
  end

  def switch_players
    @players[0], @players[1] = @players[1], @players[0]
  end

  def current_player
    @players[0]
  end

  def ask_for_turn(player)
    puts "It is your turn, #{player.name}, your mark is (#{player.marker})"
    @board.print_board
    puts "Where you want to put your mark:"
    until @board.put_mark(field = gets.chomp, player.marker)
      puts "Sorry, it is taken or out of range, choose another:"
    end
    if check_if_someone_won(field)
      @board.print_board
      puts "The winner is #{player.name}, congratulations!"
    end
  end

  def check_if_someone_won(field)
    f = field.split(" ").map {|element| element.to_i }
    if line_vertically(f) || line_horizontally(f) || line_positive_bias(f) || line_negative_bias(f)
      @is_ended = true
      return true
    end
  end

  def line_vertically(field)
    counter = 0
    for i in 0..2
      counter += 1 if @board.get_mark(field[0], field[1]) == @board.get_mark(i, field[1])
    end
    counter == 3 ? true : false
  end

  def line_horizontally(field)
    counter = 0
    for i in 0..2
      counter += 1 if @board.get_mark(field[0], field[1]) == @board.get_mark(field[0], i)
    end
    counter == 3 ? true : false
  end

  def line_positive_bias(field)
    counter = 0
    j = 0
    for i in -2..0
      counter += 1 if @board.get_mark(field[0], field[1]) == @board.get_mark(-i, j)
      j += 1
    end
    counter == 3 ? true : false
  end

  def line_negative_bias(field)
    counter = 0
    for i in 0..2
      counter += 1 if @board.get_mark(field[0], field[1]) == @board.get_mark(i, i)
    end
    counter == 3 ? true : false
  end

end