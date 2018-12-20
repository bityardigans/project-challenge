class Like < ApplicationRecord
  belongs_to :dog, counter_cache: true
end
