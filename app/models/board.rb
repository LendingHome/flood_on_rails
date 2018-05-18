class Board

	# read/write
	attr_accessor :game_board

	BOARD_SIZE = 10
	NUM_COLORS = 6

	def initialize
		@game_board = Array.new(BOARD_SIZE) { Array.new(BOARD_SIZE, 0) }
		fill_board()

	end

	# flood the board with this color
	# assumes new_color is in [1,...,NUM_COLORS]
	def flood(new_color)
		flood_helper(0, 0, @game_board[0][0], new_color)
	end

	# determine if user has won game
	def flooded?
		color = @game_board[0][0]
		0.upto(BOARD_SIZE - 1) { |x|
			0.upto(BOARD_SIZE - 1) { |y|
				return false if @game_board[x][y] != color
			}
		}
		true
	end

	# for testing
	def print_board
		@game_board.each { |x|
			x.each { |y|
				print "#{y} "
			}
			puts
		}
		return 
	end

	private

	def fill_board
		0.upto(BOARD_SIZE - 1) { |x|
			0.upto(BOARD_SIZE - 1) { |y|
				# initialize with random colors
				@game_board[x][y] = Random.rand(1..NUM_COLORS)
			}

		}
	end

	def flood_helper(x, y, old_color, new_color)
		return if new_color == old_color
		return if @game_board[x][y] != old_color

		@game_board[x][y] = new_color
		flood_helper(x - 1, y, old_color, new_color) if x - 1 >= 0
		flood_helper(x + 1, y, old_color, new_color) if x + 1 < BOARD_SIZE
		flood_helper(x, y - 1, old_color, new_color) if y - 1 >= 0
		flood_helper(x, y + 1, old_color, new_color) if y + 1 < BOARD_SIZE
	end

end


