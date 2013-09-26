require 'test/unit'
require_relative 'player.rb'
require_relative 'match.rb'

class TestTennis < Test::Unit::TestCase
    def setup
    	@match = Match.new
    end

    def test_initial_points()
    	assert_equal(0, @match.player1.points())
    	assert_equal(0, @match.player2.points())
    end
    
    def test_first_point()
        @match.score(@match.player1)
        assert_equal(15, @match.player1.points())
    end

    def test_second_point()
    	2.times {@match.score(@match.player1)}
        assert_equal(30, @match.player1.points())
    end

    def test_third_point()
        3.times {@match.score(@match.player1)}
        assert_equal(40, @match.player1.points())
        assert_equal(0, @match.player1.games())
    end
    
    def test_game()
        4.times {@match.score(@match.player1)}
    	assert_equal(0, @match.player1.points())
        assert_equal(1, @match.player1.games())
    end

    def test_deuce()
    	3.times {@match.score(@match.player1)}
    	3.times {@match.score(@match.player2)}
    	assert(@match.deuce?)
    end

    def test_advantage()
    	3.times {@match.score(@match.player1)}
    	3.times {@match.score(@match.player2)}
    	1.times {@match.score(@match.player1)}
    	assert_equal(0, @match.player1.games())
    end
    
    def test_game_after_advantage()
    	3.times {@match.score(@match.player1)}
    	3.times {@match.score(@match.player2)}
    	2.times {@match.score(@match.player1)}
    	assert_equal(0, @match.player1.points())
    	assert_equal(1, @match.player1.games())
    	assert_equal(0, @match.player2.points())
    	assert_equal(0, @match.player2.games())
    end

    def test_deuce_after_advantage()
    	3.times {@match.score(@match.player1)}
    	3.times {@match.score(@match.player2)}
    	@match.score(@match.player1)
    	@match.score(@match.player2)
    	assert(@match.deuce?)
    	assert_equal(0, @match.player1.games())
    	assert_equal(0, @match.player2.games())
    	refute(@match.player1.advantage())
    	refute(@match.player2.advantage())
    end
end