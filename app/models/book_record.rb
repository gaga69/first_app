class BookRecord < ApplicationRecord
    has_many :posts, foreign_key: 'isbn', class_name: 'Post', primary_key: 'isbn', dependent: :destroy
    validates :isbn, uniqueness: {scope: [:user_id] }
    validates :status, presence: true

end
