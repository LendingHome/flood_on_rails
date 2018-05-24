class Game

	@@total_moves = 24
	attr_reader :board
	attr_reader :state
	attr_reader :moves_remaining
	attr_reader :score

	def initialize
		@board = Board.new
		@moves_remaining = @@total_moves
		@score = 0
		@state = 0 # 0=playing, 1=won, -1=lost
	end

	def make_move(color)
		if @moves_remaining > 1
			@board.flood(color)
			@moves_remaining -= 1
			@score += 1
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