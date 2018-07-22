class ScheduleTime
    attr_reader :hour, :minute

    def initialize(hour, minute)
        @hour = hour
        @minute = minute
    end

    def add_minutes(minutes)
        new_time = to_minutes + minutes
        set_time(new_time)
    end

    def subtract_minutes(minutes)
        new_time = to_minutes - minutes
        set_time(new_time)
    end

    def to_s
        h_str = hour.to_s.rjust(2, "0")
        m_str = minute.to_s.rjust(2, "0") 

        "#{h_str}:#{m_str}"
    end

    def to_minutes
        hour * 60 + minute
    end

    private

    def set_time(minutes)
        @minute = minutes % 60
        @hour = (minutes / 60) % 24
    end
end