class Movie
    MPAA_RATINGS = [
        "G",
        "PG",
        "PG-13",
        "R",
        "NC-17"
    ]

    attr_reader :title, :release_year, :mpaa_rating, :run_time
    
    def initialize(title, release_year, mpaa_rating, run_time)
        @title = title
        @release_year = release_year
        @mpaa_rating = mpaa_rating
        @run_time = run_time
    end
end