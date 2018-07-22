require 'rspec'
require './lib/movie_scheduler'
require './lib/movie_scheduler/movie'

describe MovieScheduler do
    subject(:scheduler) { MovieScheduler.new }
    let(:movie) { Movie.new("There's Something About Mary", 1998, "R", 134) }
    let(:str) { <<~FILE
        Movie Title, Release Year, MPAA Rating, Run Time
        There's Something About Mary, 1998, R, 2:14
    FILE
}

    describe '#parse_movies' do
        it 'should create an array of movie objects from a str' do
            movies = scheduler.parse_movies(str)
            expect(movies[0].title).to eq("There's Something About Mary")
            expect(movies[0].release_year).to eq(1998)
            expect(movies[0].mpaa_rating).to eq("R")
            expect(movies[0].run_time).to eq(134)
        end
    end

    describe "#calculate_movie_schedule" do
        it "determines the optimal movie schedule" do
            scheduler.parse_movies(str)
            expect(scheduler.print_schedule(Time.new(2018,7,23,0,0,0,"-05:00"))).to eq (
                <<~SCHEDULE
                Monday 7/23/2018

                There's Something About Mary - Rated R, 2:14
                    09:25 - 11:39
                    12:15 - 14:29
                    15:05 - 17:19
                    17:55 - 20:09
                    20:45 - 22:59

                SCHEDULE
            )
        end
    end
end