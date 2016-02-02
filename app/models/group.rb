class Group < ActiveRecord::Base
  has_many :text_queries, dependent: :destroy
  has_many :numeric_queries, dependent: :destroy
  belongs_to :segment

  validates_associated :numeric_queries
  validates_associated :text_queries
  # Make queries editable through the groups
  accepts_nested_attributes_for :numeric_queries, allow_destroy: true
  accepts_nested_attributes_for :text_queries, allow_destroy: true

  def to_s
    query = ""
    self.text_queries.each do |text_query|
      query += text_query.to_s
      unless self.text_queries.last == text_query
        query += " AND "
      end
    end
    query += " AND " unless text_queries.empty? or self.numeric_queries.empty?
    self.numeric_queries.each do |numeric_query|
      query += numeric_query.to_s
      unless self.numeric_queries.last == numeric_query
        query += " AND "
      end
    end
    return query
  end
end
