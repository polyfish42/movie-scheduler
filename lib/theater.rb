require 'schedule_time'

class Theater
    MONDAY =  1
    TUESDAY =  2
    WEDNESDAY = 3
    THURSDAY = 4
    FRIDAY = 5
    SATURDAY = 6
    SUNDAY = 7

    DEFAULT_SCHEDULE = {
        MONDAY..THURSDAY => { open: ScheduleTime.new(8, 0), close: ScheduleTime.new(23, 0) },
        FRIDAY..SUNDAY => { open: ScheduleTime.new(10, 30), close: ScheduleTime.new(23, 30) }
    }

    attr_reader :turnover_time, :setup_time

    def initialize(schedule = DEFAULT_SCHEDULE)
        @schedule = schedule
        @turnover_time = 35
        @setup_time = 30
    end

    def open_time(wday)
        @schedule.each do |days, times|
            if days.cover?(wday)
                return times[:open]
            end
        end
    end

    def closed_time(wday)
        @schedule.each do |days, times|
            if days.cover?(wday)
                return times[:close]
            end
        end
    end
end