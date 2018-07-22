require 'schedule_time'

class Theater
    SUNDAY = 0
    MONDAY =  1
    TUESDAY =  2
    WEDNESDAY = 3
    THURSDAY = 4
    FRIDAY = 5
    SATURDAY = 6

    DEFAULT_SCHEDULE = {
        [MONDAY, TUESDAY, WEDNESDAY, THURSDAY] => { open: ScheduleTime.new(8, 0), close: ScheduleTime.new(23, 0) },
        [FRIDAY, SATURDAY, SUNDAY] => { open: ScheduleTime.new(10, 30), close: ScheduleTime.new(23, 30) }
    }

    attr_reader :turnover_time, :setup_time

    def initialize(schedule = DEFAULT_SCHEDULE)
        @schedule = schedule
        @turnover_time = 35
        @setup_time = 30
    end

    def open_time(wday)
        @schedule.each do |days, times|
            if days.include?(wday)
                return times[:open]
            end
        end
        nil
    end

    def closed_time(wday)
        @schedule.each do |days, times|
            if days.include?(wday)
                return times[:close]
            end
        end
        nil
    end
end