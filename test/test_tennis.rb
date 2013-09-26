require 'test/unit'
require 'tennis_game'

class TestTennis < Test::Unit::TestCase
    def setup
    	@tennis_game = TennisGame.new
    end

    def test_initial_points()
    	assert_equal(0, @tennis_game.player1.points())
    	assert_equal(0, @tennis_game.player2.points())
    end
    
    def test_first_point()
        @tennis_game.score(@tennis_game.player1)
        assert_equal(15, @tennis_game.player1.points())
    end

    def test_second_point()
    	2.times {@tennis_game.score(@tennis_game.player1)}
        assert_equal(30, @tennis_game.player1.points())
    end

    def test_third_point()
        3.times {@tennis_game.score(@tennis_game.player1)}
        assert_equal(40, @tennis_game.player1.points())
        assert_equal(0, @tennis_game.player1.games())
    end
    
    def test_game()
        4.times {@tennis_game.score(@tennis_game.player1)}
    	assert_equal(0, @tennis_game.player1.points())
        assert_equal(1, @tennis_game.player1.games())
    end

    def test_deuce()
    	3.times {@tennis_game.score(@tennis_game.player1)}
    	3.times {@tennis_game.score(@tennis_game.player2)}
    	assert(@tennis_game.deuce?)
    end

    def test_advantage()
    	3.times {@tennis_game.score(@tennis_game.player1)}
    	3.times {@tennis_game.score(@tennis_game.player2)}
    	1.times {@tennis_game.score(@tennis_game.player1)}
    	assert_equal(0, @tennis_game.player1.games())
    end
    
    def test_game_after_advantage()
    	3.times {@tennis_game.score(@tennis_game.player1)}
    	3.times {@tennis_game.score(@tennis_game.player2)}
    	2.times {@tennis_game.score(@tennis_game.player1)}
    	assert_equal(0, @tennis_game.player1.points())
    	assert_equal(1, @tennis_game.player1.games())
    	assert_equal(0, @tennis_game.player2.points())
    	assert_equal(0, @tennis_game.player2.games())
    end

    def test_deuce_after_advantage()
    	3.times {@tennis_game.score(@tennis_game.player1)}
    	3.times {@tennis_game.score(@tennis_game.player2)}
    	@tennis_game.score(@tennis_game.player1)
    	@tennis_game.score(@tennis_game.player2)
    	assert(@tennis_game.deuce?)
    	assert_equal(0, @tennis_game.player1.games())
    	assert_equal(0, @tennis_game.player2.games())
    	refute(@tennis_game.player1.advantage())
    	refute(@tennis_game.player2.advantage())
    end
end