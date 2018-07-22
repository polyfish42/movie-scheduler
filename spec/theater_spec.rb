require 'rspec'
require './lib/movie_scheduler/theater'
require './lib/movie_scheduler/schedule_time'

describe Theater do
    subject(:theater) { Theater.new }

    describe "#open_time" do
        it "returns the open time for the theater" do
            expect(theater.open_time(1)).to eq ScheduleTime.new(8,0)
        end
    end

    describe "#closing_time" do
        it "returns the closing time for the theater" do
            expect(theater.closed_time(0)).to eq ScheduleTime.new(23,30)
        end
    end
end