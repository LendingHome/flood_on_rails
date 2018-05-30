class Computer_Game

	@@total_moves = 24
	attr_reader :user_board
	attr_reader :comp_board
	attr_reader :state
	attr_reader :size

	def initialize(size)
		@user_board = Board.new(size)
		@comp_board = Marshal.load(Marshal.dump(@user_board))
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