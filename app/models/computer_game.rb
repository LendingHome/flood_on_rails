class Computer_Game

	@@total_moves = 24
	attr_reader :user_board
	attr_reader :comp_board
	attr_reader :state
	attr_reader :size
	#attr_reader :greedy_color
	#attr_reader :moves_remaining
	#attr_reader :score

	def initialize(size)
		# TODO: change
		@user_board = Board.new(size)
		@comp_board = Marshal.load(Marshal.dump(@user_board))
		#@moves_remaining = @@total_moves
		#@score = 0
		@state = 0 # 0=playing, 1=won, -1=lost
		@size = size
	end

	def make_computer_move()
		color = @comp_board.get_greedy_color()
		#@greedy_color = color
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
		user_done = @user_board.flooded?
		comp_done = @comp_board.flooded?
		if user_done 
			@state = 1
		elsif comp_done
			@state = -1
		else
			#@state = 0
		end
	end

	def print_board
		@user_board.print_board
		puts
		@comp_board.print_board
	end

end