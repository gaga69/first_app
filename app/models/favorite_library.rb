class FavoriteLibrary < ApplicationRecord
    belongs_to :user
    validates :user_id, :pref, :city, :systemid, presence: true
    validates :libid, presence: true, uniqueness: true
end
