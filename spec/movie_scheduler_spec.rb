require 'rspec'
require 'movie_scheduler'

describe MovieScheduler do
    subject(:scheduler) { MovieScheduler.new }
    let(:movie) { double("Movie") }

    describe '#parse_movies' do
        let(:str) { <<~FILE
                        Movie Title, Release Year, MPAA Rating, Run Time
                        There's Something About Mary, 1998, R, 2:14
                    FILE
        }

        it 'should create an array of movie objects from a str' do
            movies = MovieScheduler.parse_movies(str)
            expect(movies[0].title).to eq("There's Something About Mary")
            expect(movies[0].release_year).to eq(1998)
            expect(movies[0].mpaa_rating).to eq("R")
            expect(movies[0].run_time).to eq(134)
        end
    end
end