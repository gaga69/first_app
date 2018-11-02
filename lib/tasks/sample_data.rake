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
        users = User.limit(5)
        30.times do
            book_title = Faker::Book.title
            book_author = Faker::Book.author
            content = Faker::Lorem.sentence(4)
            users.each { |user| user.posts.create!(book_title: book_title,
                                                   book_author: book_author,
                                                   content: content) }
        end
    end
end


