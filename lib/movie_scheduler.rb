require_relative './movie_scheduler/theater.rb'
require_relative './movie_scheduler/movie.rb'
require_relative './movie_scheduler/schedule_time.rb'
require 'csv'

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

    def print_schedule(date)
        str = date.strftime("%A %-m/%e/%Y\n\n")

        schedule(date).each do |movie, movie_times|
            str += movie_info(movie)
            str += "\n"
            movie_times.each do |movie_time|
                str += "    #{movie_time[:start]} - #{movie_time[:end]}\n"
            end
            str += "\n"
        end
        puts str
        str
    end

    private
    def remove_spaces(str)
        str.gsub(/, /, ",")
    end

    def run_time_to_min(run_time)
        (hours, minutes) = run_time.split(":").map(&:to_i)

        hours * 60 + minutes
    end

    def movie_info(movie)
        "#{movie.title} - Rated #{movie.mpaa_rating}, #{movie.print_runtime}"
    end

    def first_possible_end_time(movie, date)
        wday = date.wday
        open_time = @theater.open_time(date.wday)
        open_time.add_minutes(@theater.setup_time)
                 .add_minutes(movie.run_time)
    end

    def movie_times(movie, date)
        time = @theater.closed_time(date.wday)
        schedule = []
    
        while time >= first_possible_end_time(movie, date)
            (start_time, end_time) = movie.start_and_end_time(time)

            schedule << {start: start_time, end: end_time}
            time = start_time.subtract_minutes(@theater.turnover_time)
        end
    
        schedule.sort_by {|movie_time| movie_time[:start]}
    end

    def schedule(date)
        @movies.reduce({}) do |schedule, movie|
            schedule[movie] = movie_times(movie, date)
            schedule
        end
    end
end

if __FILE__ == $PROGRAM_NAME
    scheduler = MovieScheduler.new
    file = ARGV[0]
    f = File.read(file)
    scheduler.parse_movies(f)
    scheduler.print_schedule(Time.now)
end