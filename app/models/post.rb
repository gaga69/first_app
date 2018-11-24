class Post < ApplicationRecord
    belongs_to :user
    belongs_to :book_record, foreign_key: 'isbn', class_name: 'BookRecord', primary_key: 'isbn'
    default_scope -> { order('created_at DESC') }
    validates :user_id, :isbn, presence: true
    validates :content, presence: true, length: { maximum: 200}

    def self.from_users_followed_by(user)
        followed_user_ids = "SELECT followed_id FROM relationships
                             WHERE follower_id = :user_id"
        where("user_id IN (#{followed_user_ids}) OR user_id = :user_id",
               user_id: user.id)
    end

end
