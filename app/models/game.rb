class Game

	@@total_moves = 24
	@@score_decrement = 38
	attr_reader :board
	attr_reader :state
	attr_reader :moves_remaining
	attr_reader :score
	attr_reader :size

	def initialize(size)
		@board = Board.new(size)
		case size
		when "Small"
			@@total_moves = 15
			@@score_decrement = 60
		when "Medium"
			@@total_moves = 24
			@@score_decrement = 38
		when "Large"
			@@total_moves = 34
			@@score_decrement = 27
		else
			@@total_moves = 24
			@@score_decrement = 38
			@size = "Medium"
		end
		@moves_remaining = @@total_moves
		@score = 1000
		@state = 0 # 0=playing, 1=won, -1=lost
		@size = size
	end

	def make_move(color)
		if @moves_remaining > 0
			return if !@board.flood(color)
			@moves_remaining -= 1
			@score -= @@score_decrement
			determine_state
		end

	end

	def determine_state
		if @board.flooded? && @moves_remaining >= 0
			@state = 1
		elsif @moves_remaining < 1
			@state = -1
		end
	end

	def print_board
		@board.print_board
	end

end