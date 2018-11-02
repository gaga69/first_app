namespace :db do
    desc "Fill database with sample data"
    task populate: :environment do
        6.times do |n|
            name = Faker::Name.first_name
            email = Faker::Internet.email
            password = "password"
            User.create!(name: name,
                         email: email,
                         password: password)
        end
    end
end


