class Post < ApplicationRecord
    belongs_to :user
    default_scope -> { order('createa_at DESC') }
    validates :user_id, :book_title, :book_author, presence: true
    validates :content, presence: true, length: { maximum: 200}

end
