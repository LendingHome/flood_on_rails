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

	def make_user_move(color)
		return if !@user_board.flood(color)
		make_computer_move()
		determine_state
	end	

	def print_board
		@user_board.print_board
		puts
		@comp_board.print_board
	end

	private

	def determine_state
		if @user_board.flooded?
			@state = 1
		elsif @comp_board.flooded?
			@state = -1
		end
	end

	def make_computer_move()
		color = @comp_board.get_greedy_color()
		@comp_board.flood(color)
	end

end