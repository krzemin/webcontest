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
    Problem.new :name => 'Easy game',
                :content => 'Problem content',
                :input => 'Input specification',
                :output => 'Output specification',
                :examples => [{ name: 'Test #1', input: '1 2 3', output: '6' }],
                :limits => { time: 3, memory: 8192 }
  end

  def new_judge
    Judge.new
  end

  def new_submission
    Submission.new
  end

  def new_env
    competitor = new_competitor
    problem = new_problem
    judge = new_judge
    submission = competitor.create_submission problem, 'c++', 'code'
    contest = new_contest
    {
      competitor: competitor,
      problem: problem,
      judge: judge,
      submission: submission,
      contest: contest
    }
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
    problem = new_problem

    assert_equal 'Easy game', problem.name
    assert_equal 'Problem content', problem.content
    assert_equal 'Input specification', problem.input
    assert_equal 'Output specification', problem.output
    assert_equal 1, problem.examples.size
    assert_equal 'Test #1', problem.examples[0][:name]
    assert_equal '1 2 3', problem.examples[0][:input]
    assert_equal '6', problem.examples[0][:output]
    assert_equal 3, problem.limits[:time]
    assert_equal 8192, problem.limits[:memory]
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

  def test_submission_properties
    problem = new_problem
    competitor = new_competitor
    submission = competitor.create_submission(problem, 'c++', 'code')

    assert_equal competitor, submission.competitor
    assert_equal problem, submission.problem
    assert_equal 'c++', submission.language
    assert_equal 'code', submission.source_code
  end

  def test_contest_submit
    env = new_env

    env[:contest].add_problem(env[:problem])
    env[:contest].register(env[:competitor])
    env[:contest].submit(env[:submission])

    assert_equal 1, env[:contest].submissions.size
    assert_equal env[:submission], env[:contest].submissions[0]
  end

  def test_contest_submit_no_such_problem
    env = new_env
    problem = Problem.new :name => 'Problem out of the contest'
    submission = env[:competitor].create_submission(problem, 'c++', 'code')

    assert_raises NoSuchProblem do
      env[:contest].submit(submission)
    end
  end

  def test_contest_submit_no_such_competitor
    env = new_env
    env[:contest].add_problem(env[:problem])
    competitor = Competitor.new 'Not registered'
    submission = competitor.create_submission(env[:problem], 'c++', 'code')

    assert_raises NoSuchRegistrant do
      env[:contest].submit(submission)
    end
  end

end

