require 'set'

class Board

	# read/write
	attr_accessor :game_board

	BOARD_SIZE = 10
	NUM_COLORS = 6

	@current_color = 1;

	def initialize
		@game_board = Array.new(BOARD_SIZE) { Array.new(BOARD_SIZE, 0) }
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
		0.upto(BOARD_SIZE - 1) { |x|
			0.upto(BOARD_SIZE - 1) { |y|
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
		0.upto(BOARD_SIZE - 1) { |x|
			0.upto(BOARD_SIZE - 1) { |y|
				if color_count.key?(@game_board[x][y])
					color_count[@game_board[x][y]] = color_count[@game_board[x][y]] + 1
				else
					color_count[@game_board[x][y]] = 1
				end
			}
		}
		sorted_counts = color_count.sort_by { |col, count| count }
		edge_colors = get_edge_colors
		-1.downto(-edge_colors.size()) { |x|
			return sorted_counts[x][0] if sorted_counts[x][0] != @game_board[0][0] && edge_colors.include?(sorted_counts[x][0])
		}

		#return sorted_counts[-1][0] if sorted_counts[-1][0] != @game_board[0][0]
		#sorted_counts[-2][0]
	end

	def get_edge_colors()
		edge_colors = Set.new
		@finished_coords = []
		edge_colors = get_edge_colors_helper(0, 0, @game_board[0][0], edge_colors)

		#edge_colors.delete_if { |x| x.is_a?(Set) }
		edge_colors.delete(nil)
	end

	def get_edge_colors_helper(x, y, old_color, edge_colors)
		return @game_board[x][y] if @game_board[x][y] != old_color
		return nil if @finished_coords.include?([x,y])

		@finished_coords.push([x,y])
		#edge_colors.add(get_edge_colors_helper(x - 1, y, old_color, edge_colors)) if x - 1 >= 0
		edge_colors.add(get_edge_colors_helper(x + 1, y, old_color, edge_colors)) if x + 1 < BOARD_SIZE
		#edge_colors.add(get_edge_colors_helper(x, y - 1, old_color, edge_colors)) if y - 1 >= 0
		edge_colors.add(get_edge_colors_helper(x, y + 1, old_color, edge_colors)) if y + 1 < BOARD_SIZE
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


