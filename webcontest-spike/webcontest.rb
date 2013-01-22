module WebContest
  
  class Competitor
    attr_reader :name
    
    def initialize(name)
      @name = name
    end
    
    def create_submission(problem, language, source_code)
      Submission.new :competitor => self,
                     :problem => problem,
                     :language => language,
                     :source_code => source_code
    end
  end

  class Contest
    attr_reader :name, :registrants, :problems, :judges, :submissions
    def initialize(name)
      @name = name
      @registrants = []
      @problems = []
      @judges = []
      @submissions = []
      @ranking = Ranking.new
    end

    def register(contestant)
      @registrants << contestant
    end
    
    def add_problem(problem)
      @problems << problem
    end

    def add_judge(judge)
      @judges << judge
    end
    
    def submit(submission)
      @submissions << submission
    end
  end

  class Problem
    attr_reader :name, :content, :input, :output, :examples, :limits
    def initialize(opts)
      @name = opts[:name] || ''
      @content = opts[:content] || ''
      @input = opts[:input] || ''
      @output = opts[:output] || ''
      @examples = opts[:examples] || []
      @limits = opts[:limits] || { time: 0, memory: 0 }
    end
  end

  class Submission
    attr_reader :competitor, :problem, :language, :source_code
    def initialize(opts)
      @competitor = opts[:competitor]
      @problem = opts[:problem]
      @language = opts[:language]
      @source_code = opts[:source_code]
    end
  end

  class Judge
  end

  class Ranking
  end

end

