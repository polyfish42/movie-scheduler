require_relative './movie.rb'
require 'csv'

class MovieScheduler
    def self.parse_movies(str)
        csv = remove_spaces(str)
        table = CSV.parse(csv, headers: true)

        table.reduce([]) do |movies, movie|
            title = movie["Movie Title"]
            release_year = movie["Release Year"].to_i
            mpaa_rating = movie["MPAA Rating"]
            run_time = run_time_to_min(movie["Run Time"])

            movies << Movie.new(title, release_year, mpaa_rating, run_time)
            movies
        end
    end

    private

    def self.remove_spaces(str)
        str.gsub(/, /, ",")
    end

    def self.run_time_to_min(run_time)
        (hours, minutes) = run_time.split(":").map(&:to_i)

        hours * 60 + minutes
    end
end
