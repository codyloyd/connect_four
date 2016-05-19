class ConnectFour
	attr_accessor :game_array
	def initialize
		create_game_array
		draw_board
		play_game
	end

	def create_game_array
		@game_array = Array.new(6) { Array.new(7," ") }
	end

	def drop_marker(player,column)
		if @game_array[5][column] == " "
			@game_array.each_with_index do |ary,i|
				if ary[column] == " "
					ary[column] = player.marker
					break
				end 		
			end
		else
			puts "invalid move, try again loser."
			prompt_for_play(player)
		end

	end

	def game_over?
		@game_array.each_with_index do |ary,index|
			#tests for horizontal win
			4.times do |i|
				if ary[i,4] == ["X","X","X","X"] || ary[i,4] == ["O","O","O","O"]
					return true
				end
			end
			#tests for vertical win
			if index < 2
				7.times do |i|
					temp_ary = []
					4.times do |x|				
						temp_ary << @game_array[index+x][i]
					end
					if temp_ary == ["X","X","X","X"] || temp_ary == ["O","O","O","O"]
						return true
					end
				end
				#tests for diagonal win
				7.times do |i|
					temp_ary = []
					4.times do |x|				
						temp_ary << @game_array[index+x][i+x]
					end
					if temp_ary == ["X","X","X","X"] || temp_ary == ["O","O","O","O"]
						return true
					end
				end
				7.times do |i|
					temp_ary = []
					4.times do |x|				
						temp_ary << @game_array[index+x][i-x]
					end
					if temp_ary == ["X","X","X","X"] || temp_ary == ["O","O","O","O"]
						return true
					end
				end
			end
			return true if @game_array.any? { |x| x == " "}
		end

		return false
	end

	def prompt_for_play(player)
		puts "#{player.name}, it's your turn."
		puts "where would you like to drop your marker (enter 1-7)"
		response = gets.chomp
		drop_marker(player,response.to_i-1)
		draw_board
	end

	def create_players
		puts "Player 1, what is your name?"
		player_1_name = gets.chomp
		puts "Player 2, what is your name?"
		player_2_name = gets.chomp
		@player_1 = Player.new(player_1_name,"X")
		@player_2 = Player.new(player_2_name,"O")
	end

	def play_game
		create_players
		loop do
			prompt_for_play(@player_1)
			break if game_over?
			prompt_for_play(@player_2)
			break if game_over?
		end
		puts "Game Over!"
	end

	def draw_board 
		system "clear"
		def puts_row
			puts "+---+---+---+---+---+---+---+"
		end
		@game_array.reverse.each do |ary|
			puts_row
			ary.each do |x|
				print "| #{x} "
			end
			print "|"
			puts
		end
		puts "+-1-+-2-+-3-+-4-+-5-+-6-+-7-+"
	end
end

class Player
	attr_accessor :name, :marker
	def initialize(name,marker)
		@name = name
		@marker = marker
	end
end

game = ConnectFour.new