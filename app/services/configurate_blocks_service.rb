class ConfigurateBlocksService

    def initialize
        super
    end

    def self.update_blocks(service_id, data)
        saved = true
        return false if data.blank?

        service = Service.find_by_id(service_id)
        return false if service.blank?

        data.each do |key, value|
            if value["from"].blank? || value["to"].blank?
                 service_block = ServiceBlock.find_by(service_id: service.id, week_day: key)
                 service_updated = service_block.delete! if !service_block.blank?
            else
                service_block = ServiceBlock.find_or_initialize_by(service_id: service.id, week_day: key)
                service_block.from = value["from"]
                service_block.to = value["to"]
                
                service_updated = service_block.save!
            end
            saved = false if !service_updated
        end

        return saved
    end

    def self.get_blocks(service_id)
        blocks = ServiceBlock.where(service_id: service_id)
        data = {}

        week_days.each do |day|
            data[day] = {from: "", to: ""}
            block = blocks.select{|x| x.week_day.to_s == day.to_s}.first
            next if block.blank?
            
            data[day] = {from: block.from.strftime('%H:%M'), to: block.to.strftime('%H:%M')}
        end

        return data
    end

    private

    def self.week_days
        WeekDaysService.get_days
    end
end