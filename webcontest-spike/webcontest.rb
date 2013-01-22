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
      @ranking = []
    end

    def register(contestant)
      @registrants << contestant
    end
  end

  class Problem
  end

  class Submission
  end

  class Judge
  end

  class Ranking
  end

end

