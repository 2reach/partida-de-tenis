require 'player'

class TennisGame
	attr_accessor :player1, :player2

	def initialize
    	@player1 = Player.new
    	@player2 = Player.new
    end

    def score(player)
    	if player.points < 30
    		player.points += 15
    	elsif player.points == 30
            player.points += 10
        elsif deuce?
    		player.advantage = true
        elsif player.advantage
        	game(player)
        elsif advantage?
        	reset_advantage
        else
        	game(player)
        end
    end

    def game(player)
    	player.games += 1
    	@player1.points = 0 
    	@player2.points = 0 
    end

    def advantage?
    	@player1.advantage || @player2.advantage
    end

	def deuce?
		@player1.points == 40 && @player2.points == 40 && !advantage?
	end

	def reset_advantage
		@player1.advantage = false
		@player2.advantage = false
	end
end