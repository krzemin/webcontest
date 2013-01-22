module WebContest
  
  class Competitor
    attr_reader :name
    def initialize(name)
      @name = name
    end
  end

  class Contest
    attr_reader :name, :registrants
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
  end

  class Judge
  end

  class Ranking
  end

end

