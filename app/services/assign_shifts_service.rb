class AssignShiftsService

    def self.by_service(service_id)
        blocks = ServiceBlock.where(service_id: service_id)
        @assigns = {}
        @day_availabilities = Availability.all.group(:user_id).size #counter of total availability by user

        # foreach for assign all turns where is one only users available
        blocks.each do |block|

            (block.from.strftime("%H")..block.to.strftime("%H")).each do |hour|
                block_hour = "#{hour}:00"
                
                availabilities = Availability.where(week_day: block.week_day, hour: block_hour)

                if availabilities.size == 1
                    new_shift = save_shift(service_id, block.week_day, block_hour, availabilities.first.user_id)
                end
            end
        end

        # discount assign turns of each user
        @day_availabilities.collect{ |k,v| @day_availabilities[k] = v.to_f - @assigns[k].to_f }

        # foreach for assign all turns where are many users available
        blocks.each do |block|
            last_assign = nil

            (block.from.strftime("%H")..block.to.strftime("%H")).each do |hour|
                block_hour = "#{hour}:00"
                next if Shift.where(service_id: service_id, week_day: block.week_day, hour: block_hour).size > 0
                
                availabilities = Availability.where(week_day: block.week_day, hour: block_hour)
                next if availabilities.blank?

                # if the previous day has not assign or is the first day of week or the previous assign is not on the list of availables
                if last_assign.blank? || !availabilities.pluck(:user_id).uniq.include?(last_assign)
                    # get user with more time available
                    user_id = @day_availabilities.select{|k,v| availabilities.pluck(:user_id).include?(k)}.max_by{|k,v| v}.first

                    new_shift = save_shift(service_id, block.week_day, block_hour, user_id)
                    last_assign = user_id #recognize wich user was the previous asssigned

                # if the previous assign user is on the list of availables
                elsif availabilities.pluck(:user_id).uniq.include?(last_assign)
                    new_shift = save_shift(service_id, block.week_day, block_hour, last_assign)
                end
            end
        end

    end

    private

    def self.save_shift(service_id, week_day, hour, user_id)
        new_shift = Shift.find_or_create_by(service_id: service_id, week_day: week_day, hour: hour)
        new_shift.update(user_id: user_id)

        @assigns[user_id] = @assigns[user_id].to_f + 1 #counter for assigned users
        @day_availabilities[user_id] = @day_availabilities[user_id].to_f - 1
        return new_shift
    end
end