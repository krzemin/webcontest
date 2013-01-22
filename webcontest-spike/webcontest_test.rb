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

  def new_problem
    Problem.new(:name => 'Easy game',
                :content => 'Problem content',
                :input => 'Input specification',
                :output => 'Output specification',
                :examples => [{ name: 'Test #1', input: '1 2 3', output: '6' }],
                :limits => { time: 3, memory: 8192 })
  end

  def new_judge
    Judge.new
  end

  def new_submission
    Submission.new
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

  def test_problem_properties
    p = new_problem

    assert_equal 'Easy game', p.name
    assert_equal 'Problem content', p.content
    assert_equal 'Input specification', p.input
    assert_equal 'Output specification', p.output
    assert_equal 1, p.examples.size
    assert_equal 'Test #1', p.examples[0][:name]
    assert_equal '1 2 3', p.examples[0][:input]
    assert_equal '6', p.examples[0][:output]
    assert_equal 3, p.limits[:time]
    assert_equal 8192, p.limits[:memory]
  end

  def test_add_problem_to_contest
    contest = new_contest
    problem = new_problem

    contest.add_problem(problem)
    assert_equal 1, contest.problems.size
    assert_equal problem, contest.problems[0]
  end

  def test_add_judge_to_contest
    contest = new_contest
    judge = new_judge

    contest.add_judge(judge)
    assert_equal 1, contest.judges.size
    assert_equal judge, contest.judges[0]
  end

  def test_contest_submit
    contest = new_contest
    submission = new_submission

    contest.submit(submission)
    assert_equal 1, contest.submissions.size
    assert_equal submission, contest.submissions[0]
  end


end

