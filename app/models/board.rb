class Board

	# read/write
	attr_accessor :game_board

	SMALL_BOARD_SIZE = 6
	MEDIUM_BOARD_SIZE = 10
	LARGE_BOARD_SIZE = 14
	NUM_COLORS = 6

	@current_color = 1;

	def initialize(size)
		case size
		when 'Small'
			@board_size = SMALL_BOARD_SIZE
		when 'Medium'
			@board_size = MEDIUM_BOARD_SIZE
		when 'Large'
			@board_size = LARGE_BOARD_SIZE
		else
			@board_size = MEDIUM_BOARD_SIZE
		end
		@game_board = Array.new(@board_size) { Array.new(@board_size, 0) }
		fill_board()
		@current_color = @game_board[0][0]
	end

	# flood the board with this color
	# assumes new_color is in [1,...,NUM_COLORS]
	def flood(new_color)
		return false if new_color == @current_color
		@current_color = new_color
		flood_helper(0, 0, @game_board[0][0], new_color)
		true
	end

	# determine if user has won game
	def flooded?
		color = @game_board[0][0]
		0.upto(@board_size - 1) { |x|
			0.upto(@board_size - 1) { |y|
				return false if @game_board[x][y] != color
			}
		}
		true
	end

	# for testing
	def print_board()
		@game_board.each { |x|
			x.each { |y|
				print "#{y} "
			}
			puts
		}
		return 
	end

	# returns the color that occurs the most on the board, other than the current color
	def get_greedy_color()
		color_count = Hash.new
		0.upto(@board_size - 1) { |x|
			0.upto(@board_size - 1) { |y|
				if color_count.key?(@game_board[x][y])
					color_count[@game_board[x][y]] = color_count[@game_board[x][y]] + 1
				else
					color_count[@game_board[x][y]] = 1
				end
			}
		}

		sorted_counts = color_count.sort_by { |col, count| count }
		edge_colors = get_edge_colors
		-1.downto(-6) { |x|
			return sorted_counts[x][0] if sorted_counts[x][0] != @game_board[0][0] && edge_colors.include?(sorted_counts[x][0])
		}
	end

	private

	def fill_board
		0.upto(@board_size - 1) { |x|
			0.upto(@board_size - 1) { |y|
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
		flood_helper(x + 1, y, old_color, new_color) if x + 1 < @board_size
		flood_helper(x, y - 1, old_color, new_color) if y - 1 >= 0
		flood_helper(x, y + 1, old_color, new_color) if y + 1 < @board_size
	end

	# get colors on the border (so that flooding with this color will expand the flooded space)
	def get_edge_colors()
		orig_col = @game_board[0][0]
		queue = Array.new
		visited = Array.new
		edge_colors = Array.new
		queue.push([0,0])

		while !queue.empty?
			coords = queue.shift()
			visited.push(coords)
			x = coords[0]
			y = coords[1]

			if @game_board[x][y] != orig_col
				edge_colors.push(@game_board[x][y]) if !(edge_colors.include?(@game_board[x][y]))
			else
				queue.push([x + 1, y]) if x + 1 < @board_size && !(visited.include? [x + 1, y]) && !(queue.include? [x + 1, y])
				queue.push([x, y + 1]) if y + 1 < @board_size && !(visited.include? [x, y + 1]) && !(queue.include? [x, y + 1])
			end
		end
		edge_colors
	end

end


