# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

User.create(email: "ernesto@prueba.com", name: "Ernesto", password: "123456789")
User.create(email: "barbara@prueba.com", name: "Barbara", password: "123456789")
User.create(email: "Benjamin@prueba.com", name: "Benjamin", password: "123456789")

service = Service.find_or_create_by(name:"recorrido")

days = WeekDaysService.get_days
days[0..-3].each do |day|
    ServiceBlock.find_or_create_by(week_day: day, from: "19:00", to: "23:00", service_id: service.id)
end
days[-2..-1].each do |day|
    ServiceBlock.find_or_create_by(week_day: day, from: "10:00", to: "23:00", service_id: service.id)
end

hours = (19..23).map{|x| "#{x}:00".to_time.strftime("%H:%M")}

# availability user1
user1 = User.find_by_name("Ernesto")
["tuesday", "thursday", "friday"].each do |day|
    hours.each do |hour|
        Availability.find_or_create_by(user_id: user1.id, week_day: day, hour: hour)
    end
end

(10..14).map{|x| "#{x}:00".to_time.strftime("%H:%M")}.each do |hour|
    Availability.find_or_create_by(user_id: user1.id, week_day: "saturday", hour: hour)
end

# availability user2
user2 = User.find_by_name("Barbara")
["tuesday", "wednesday", "thursday", "friday"].each do |day|
    hours.each do |hour|
        Availability.find_or_create_by(user_id: user2.id, week_day: day, hour: hour)
    end
end

(18..20).map{|x| "#{x}:00".to_time.strftime("%H:%M")}.each do |hour|
    Availability.find_or_create_by(user_id: user2.id, week_day: "saturday", hour: hour)
end

(10..23).map{|x| "#{x}:00".to_time.strftime("%H:%M")}.each do |hour|
    Availability.find_or_create_by(user_id: user2.id, week_day: "saturday", hour: hour)
end

# availability user3
user3 = User.find_by_name("Benjamin")
["monday", "tuesday", "wednesday", "thursday"].each do |day|
    hours.each do |hour|
        Availability.find_or_create_by(user_id: user3.id, week_day: day, hour: hour)
    end
end

AssignShiftsService.by_service(service.id)

puts true