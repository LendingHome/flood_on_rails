class Game

	@@total_moves = 24
	@@score_decrement = 38
	attr_reader :board
	attr_reader :state
	attr_reader :moves_remaining
	attr_reader :score
	attr_reader :size

	def initialize(size=nil, board_id=nil)
		if board_id
			board_params = SavedGame.find_by_id(board_id)
			size = board_params[:size] unless !(board_params)
		end
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
		end
		@size = size
		@state = 0 # 0=playing, 1=won, -1=lost

		# Load existing board or create new board
		if board_params
			@board = Board.new(board_params[:size],board_params[:board])
			if board_params[:board_type] == 'new'
				@score = 1000
				@moves_remaining = @@total_moves
			else
				@score = board_params[:score]
				@moves_remaining = board_params[:moves]
			end
		else
			@board = Board.new(size)
			@moves_remaining = @@total_moves	
			@score = 1000
		end

		determine_state
	end

	def make_move(color)
		if @moves_remaining > 1
			return if !@board.flood(color)
			@moves_remaining -= 1
			@score -= @@score_decrement
		end
		determine_state
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