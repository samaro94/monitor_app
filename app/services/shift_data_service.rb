class ShiftDataService

    def self.get_data(shift_type, users, range, service_id = nil)
        data = {}
        @users = users
        @range = range

        if shift_type=="availability"
            data = get_availability

        end

        data =  case shift_type
                    when 'availability'
                        get_availability
                    when 'service_availability'
                        get_service_availability(service_id)
                    when 'service_shifts'
                        get_service_shifts(service_id)
                end

        return data
    end

    private

    def self.get_availability
        data = {}
        WeekDaysService.get_days.each do |day|
            data[day] = []
            shifts = Availability.where(user_id: @users.pluck(:id), week_day: day).uniq
            user_arr = @users.pluck(:id)
            
            @range.each do |hour|
                hash = {hour: hour}
                user_arr.each do |u|
                    hash["user-#{u}"] = !shifts.select{ |x| x.user_id == u && x.hour.strftime("%H:%M") == hour }.empty?
                end

                data[day].push(hash)
            end
        end
        return data
    end

    def self.get_service_availability(service_id)
        data = {}
        blocks = ServiceBlock.where(service_id: service_id)
        user_arr = @users.pluck(:id)
        shifts = Availability.where(user_id: user_arr).uniq

        WeekDaysService.get_days.each do |day|
            data[day] = []
            block = blocks.select{|x| x.week_day == day}.first
            
            next if block.blank?

            (block.from.strftime("%H")..block.to.strftime("%H")).each do |hour|
                hash = {hour: "#{hour}:00"}
                
                user_arr.each do |u|
                    hash["user-#{u}"] = !shifts.select{ |x| x.user_id == u && x.week_day == day && x.hour.strftime("%H:%M") == "#{hour}:00" }.empty?
                end

                data[day].push(hash)
            end
        end

        return data
    end

    def self.get_service_shifts(service_id)
        data = {}
        blocks = ServiceBlock.where(service_id: service_id)
        user_arr = @users.pluck(:id)
        shifts = Shift.where(user_id: user_arr).uniq

        WeekDaysService.get_days.each do |day|
            data[day] = []
            block = blocks.select{|x| x.week_day == day}.first
            
            next if block.blank?

            (block.from.strftime("%H")..block.to.strftime("%H")).each do |hour|
                hash = {hour: "#{hour}:00"}
                
                user_arr.each do |u|
                    hash["user-#{u}"] = !shifts.select{ |x| x.user_id == u && x.week_day == day && x.hour.strftime("%H:%M") == "#{hour}:00" }.empty?
                end

                data[day].push(hash)
            end
        end

        return data
    end

end