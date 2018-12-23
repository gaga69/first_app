class Place < ApplicationRecord
    include JpPrefecture
    jp_prefecture :prefecture_code
end
