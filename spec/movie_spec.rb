require 'rspec'
require './lib/movie_scheduler/movie.rb'
require './lib/movie_scheduler/schedule_time'

describe Movie do
    subject(:movie) { Movie.new("There's Something About Mary", 1998, "R", 134)}
    let(:time1) {ScheduleTime.new(18,14)}
    let(:time2) {ScheduleTime.new(18,0)}

    describe "#start_and_end_time" do
        it "pick a start and end time" do
            (start_time, end_time) = movie.start_and_end_time(time1)

            expect(start_time.to_s).to eq "16:00"
            expect(end_time.to_s).to eq "18:14"
        end

        it "picks start time in intervals of five minutes" do
            (start_time, end_time) = movie.start_and_end_time(time2)

            expect(start_time.to_s).to eq "15:45"
            expect(end_time.to_s).to eq "17:59"
        end
    end

    describe "#print_runtime" do
        it "prints movie run times over an hour" do
            expect(movie.print_runtime).to eq "2:14"
        end
    end
end