require 'test/unit'
require './webcontest'

include WebContest

class WebContestTest < Test::Unit::TestCase

  def new_contest
    Contest.new('Contest demo')
  end

  def new_competitor
    Competitor.new('Piotr')
  end

  def test_competitor_has_name
    assert_equal 'Piotr', new_competitor.name
  end

  def test_contest_has_name
    assert_equal 'Contest demo', new_contest.name 
  end

  def test_register_for_contest
    contest = new_contest
    competitor = new_competitor

    assert_equal 0, contest.registrants.size
    contest.register(competitor)
    assert_equal 1, contest.registrants.size
    assert_equal competitor, contest.registrants[0]
  end

end

