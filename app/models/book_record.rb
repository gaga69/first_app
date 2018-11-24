class BookRecord < ApplicationRecord
    validates :isbn, uniqueness: {scope: [:user_id] }
end
