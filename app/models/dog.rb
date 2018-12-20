class Dog < ApplicationRecord
  has_many_attached :images
  has_one :users
  has_many :likes

  def trending
    self[:trending]
  end
  
  def trending=(val)
    self[:trending] = val
  end

  def self.get_dogs(order_by)
    case order_by
      when "trending"
        order_by_trend()
      when "likes"
        all.order(likes_count: :desc)
      else
        all.order(:name)
    end        
  end

  # get dogs trending order by likes in last hour - wrap sql in Arel for rails 6 compliancy
  def self.order_by_trend()
    includes(:likes)
      .select('dogs.*, COUNT(likes.id) > 0 as trending')
      .joins("LEFT OUTER JOIN Likes ON likes.dog_id = dogs.id AND likes.created_at >= DATETIME(date('now'), '-60 minutes')")
      .group("dogs.id")      
      .order(Arel.sql("COUNT(likes.id) DESC"))
  end  
end
