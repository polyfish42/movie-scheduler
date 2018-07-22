require_relative './movie.rb'
require_relative './theater.rb'
require 'csv'
require 'byebug'

class MovieScheduler
    def initialize()
        @theater = Theater.new
        @movies = []
    end

    def parse_movies(str)
        csv = remove_spaces(str)
        table = CSV.parse(csv, headers: true)

        @movies = table.map do |movie|
            title = movie["Movie Title"]
            release_year = movie["Release Year"].to_i
            mpaa_rating = movie["MPAA Rating"]
            run_time = run_time_to_min(movie["Run Time"])

            Movie.new(title, release_year, mpaa_rating, run_time)
        end
    end

    def schedule(date)
        str = date.strftime("%A %-m/%e/%Y\n\n")

        @movies.each do |movie|
            str += "#{movie.title} - Rated #{movie.mpaa_rating}, #{movie.print_runtime}\n"
            arr = []
            schedule = calculate_movie_schedule(movie, date)
            schedule.each do |movie_time|
                arr << "    #{movie_time[:start]} - #{movie_time[:end]}\n"
            end
            str += arr.reverse.join("") + "\n"
        end
        str
    end

    private
    def calculate_movie_schedule(movie, date)
        time = @theater.closed_time(date.wday)
        schedule = []
    
        while time > first_possible_end_time(movie, date)
            (start_time, end_time) = movie.start_and_end_time(time)

            schedule << {start: start_time, end: end_time}
            time = start_time.subtract_minutes(@theater.turnover_time)
        end
    
        schedule
    end

    def first_possible_end_time(movie, date)
        wday = date.wday
        open_time = @theater.open_time(date.wday)
        open_time.add_minutes(@theater.setup_time)
                 .add_minutes(movie.run_time)
    end

    def remove_spaces(str)
        str.gsub(/, /, ",")
    end

    def run_time_to_min(run_time)
        (hours, minutes) = run_time.split(":").map(&:to_i)

        hours * 60 + minutes
    end
end