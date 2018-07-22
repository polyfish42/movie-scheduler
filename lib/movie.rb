class Movie
    attr_reader :title, :release_year, :mpaa_rating, :run_time

    def initialize(title, release_year, mpaa_rating, run_time)
        @title = title
        @release_year = release_year
        @mpaa_rating = mpaa_rating
        @run_time = run_time
    end

    def start_and_end_time(time)
        start_time = time.subtract_minutes(@run_time)
        start_time = round_down_to_multiple_of_five(start_time)
        end_time = start_time.add_minutes(@run_time)

        [start_time, end_time]
    end

    def print_runtime
        hour = @run_time / 60
        h_str = hour.to_s
        minute = @run_time % 60
        m_str = minute.to_s.rjust(2, "0") 

        "#{h_str}:#{m_str}"
    end

    private

    def round_down_to_multiple_of_five(time)
        new_minutes = time.minute - time.minute / 5 * 5
        time.subtract_minutes(new_minutes)
    end
end