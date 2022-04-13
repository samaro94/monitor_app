class UpdateShiftService

    def self.update_all_users(data)

        data.each do |day, arr|
            arr.each do |row|
                row.except("hour").each do |key, value|
                    key_params = { week_day: day, hour: row["hour"], user_id: key.split("-")[-1] }
                    if value
                        Availability.find_or_create_by( key_params )
                    else
                        availability = Availability.find_by( key_params )
                        availability.delete if !availability.blank?
                    end
                end
            end
        end

        return true
    end
end