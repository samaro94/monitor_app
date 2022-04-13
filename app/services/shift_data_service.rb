class ShiftDataService

    def self.get_data(shift_type, users, range)
        data = {}

        WeekDaysService.get_days.each do |day|
            data[day] = []
            shifts = Availability.where(user_id: users.pluck(:id), week_day: day).uniq
            user_arr = users.pluck(:id)
            
            range.each do |hour|
                hash = {hour: hour}
                user_arr.each do |u|
                    hash["user-#{u}"] = !shifts.select{ |x| x.user_id == u && x.hour.strftime("%H:%M") == hour }.empty?
                end

                data[day].push(hash)
            end
        end

        return data
    end

    private

end