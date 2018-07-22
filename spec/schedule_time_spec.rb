require 'rspec'
require 'schedule_time'
require 'byebug'

describe ScheduleTime do
    subject(:time) { ScheduleTime.new(10,45)}

    describe "#add_minutes" do
        it "adds minutes to time" do
            time.add_minutes 95

            expect(time.hour).to eq 12
            expect(time.minute).to eq 20
        end

        it "correctly handles midnight" do
            time.add_minutes 840

            expect(time.hour).to eq 0
            expect(time.minute).to eq 45
        end
    end

    describe "#subtract_minutes" do
        it "subtracts minutes from time" do
            time.subtract_minutes 115

            expect(time.hour).to eq 8
            expect(time.minute).to eq 50
        end

        it "correctly handles midnight" do
            time.subtract_minutes 690

            expect(time.hour).to eq 23
            expect(time.minute).to eq 15
        end
    end

    describe "#to_s" do
        it "returns formatted time" do
            expect(time.to_s).to eq "10:45"
        end

        it "pads time correctly" do
            time.subtract_minutes 640

            expect(time.to_s).to eq "00:05"
        end
    end

    describe "#to_minutes" do
        it "converts time to minutes" do
            expect(time.to_minutes).to eq 645
        end
    end
end