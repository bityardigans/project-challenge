class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.page(page: 1, limit: 5)    
    @page = page ||= 1
    @limit = limit ||= 5

    limit(@limit).offset((page <= 0 ? 0 : @page-1) * @limit)
  end

  def self.total_pages(limit: 5, total: nil)
    @total = total ||= all.count
    @limit = limit ||= 5

    # set total pages - cast to float for math the ceiling to nearest whole
    (@total.to_f  / @limit.to_f).ceil
  end
end
