# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.create(username: 'test', password: 'SuperS3cret!')

appointments = [
                {
                  chore: "clean",
                  date: Time.now,
                  status: 'in progress',
                  provider_id: 75,
                  cost: 76.89
                },
                {
                  chore: 'moving',
                  date: 3.days.from_now,
                  status: 'approved',
                  provider_id: 72,
                  cost: 112.31
                },
                {
                  chore: 'mowing',
                  date: 2.days.ago,
                  status: 'finalized',
                  provider_id: 90,
                  cost: 54.71
                }]

appointments.each do |appointment|
  Appointment.create(chore: appointment[:chore], user_id: user.id, date: appointment[:date], status: appointment[:status], cost: appointment[:cost])
end
