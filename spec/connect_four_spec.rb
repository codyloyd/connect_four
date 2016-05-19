require './connect_four'

describe "ConnectFour" do
	describe "game_array" do
		before(:each) do
			@game = ConnectFour.new
			@game.create_game_array
		end

		it "creates an array of spaces called @game_array" do
			expect(@game.game_array).to  eql([[' ',' ',' ',' ',' ',' ',' '],
											  [' ',' ',' ',' ',' ',' ',' '],
											  [' ',' ',' ',' ',' ',' ',' '],
											  [' ',' ',' ',' ',' ',' ',' '],
											  [' ',' ',' ',' ',' ',' ',' '],
											  [' ',' ',' ',' ',' ',' ',' '],])
		end

		it "creates a 2d array that can be edited like expected" do
			@game.game_array[0][0] = 'X'
			expect(@game.game_array[0]).to eql(['X',' ',' ',' ',' ',' ',' '])
		end
	end


	describe "drop_marker" do
		subject(:game) {ConnectFour.new}
		let(:player_1) {Player.new("cody","X")}
		before do
			game.create_game_array
		end
		it "places a marker in the correct position" do
			game.drop_marker(player_1,0)
			expect(game.game_array[0][0]).to eql("X")
		end
		it "places a marker in another correct position" do
			game.drop_marker(player_1,3)
			expect(game.game_array[0][3]).to eql("X")
		end
		it "stacks markers correctly" do
			game.drop_marker(player_1,0)
			game.drop_marker(player_1,0)
			expect(game.game_array[1][0]).to eql("X")
		end
		it "stacks more markers correctly" do
			game.drop_marker(player_1,2)
			game.drop_marker(player_1,2)
			game.drop_marker(player_1,2)
			game.drop_marker(player_1,2)
			expect(game.game_array[3][2]).to eql("X")
		end
	end

	describe "game_over?" do
		subject(:game) { ConnectFour.new() }
		let(:player_1) {Player.new("Cody","X")}
		before do 
			game.create_game_array
		end
		context "horizontal wins" do
			it "reports a win if there are 4 in a row horizontally" do
				4.times { |x| game.drop_marker(player_1,(x+2)) }
				expect(game.game_over?).to eql(true)
			end
			it "works for horiz. rows not on the bottom" do 
				game.game_array[3] = [" "," ","X","X","X","X"," "]
				expect(game.game_over?).to eql(true)
			end
		end
		context "vertical wins" do 
			it "reports a win if there are  4 vertical marks" do
				4.times {  game.drop_marker(player_1,0) }
				expect(game.game_over?).to eql(true)
			end
			it "reports a win if 4 vertical marks, not on the bottom" do
				4.times {  |x| game.game_array[x+1][2] = "X" }
				expect(game.game_over?).to eql(true)
			end
			it "reports a win if 4 vertical marks, not on the bottom" do
				4.times {  |x| game.game_array[x+2][6] = "X" }
				expect(game.game_over?).to eql(true)
			end
		end
		context "diagonal wins" do 
			it "reports a  rising diagonal win" do 
				4.times { |x| game.game_array[x][x] = "X"}
				expect(game.game_over?).to eql(true)
			end
			it "reports a  rising diagonal win" do 
				4.times { |x| game.game_array[x+1][x+2] = "X"}
				expect(game.game_over?).to eql(true)
			end
			it "reports a descending diagonal win" do 
				4.times { |x| game.game_array[4-x][x] = "X"}
				expect(game.game_over?).to eql(true)
			end
			it "reports another descending diagonal win" do 
				game.game_array[4][0] = "X"
				game.game_array[3][1] = "X"
				game.game_array[2][2] = "X"
				game.game_array[1][3] = "X"
				expect(game.game_over?).to eql(true)
			end
			it "reports a 3rd descending diagonal win" do 
				game.game_array[3][3] = "X"
				game.game_array[2][4] = "X"
				game.game_array[1][5] = "X"
				game.game_array[0][6] = "X"
				expect(game.game_over?).to eql(true)
			end
		end
	end
end