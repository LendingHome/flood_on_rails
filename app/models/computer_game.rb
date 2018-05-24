class Computer_Game

	@@total_moves = 24
	attr_reader :user_board
	attr_reader :comp_board
	attr_reader :state
	#attr_reader :moves_remaining
	#attr_reader :score

	def initialize
		@user_board = Board.new
		@comp_board = Marshal.load(Marshal.dump(@user_board))
		#@moves_remaining = @@total_moves
		#@score = 0
		@state = 0 # 0=playing, 1=won, -1=lost
	end

	def make_computer_move()
		color = @comp_board.get_greedy_color()
		@comp_board.flood(color)
	end

	def make_user_move(color)
		@user_board.flood(color)
		make_computer_move()
		#@moves_remaining -= 1
		#@score += 1
		determine_state

	end

	

	def determine_state
		if @user_board.flooded? #&& @moves_remaining >= 0
			@state = 1
		#elsif @moves_remaining < 1
		#	@state = -1
		end
	end

	def print_board
		@board.print_board
	end

end