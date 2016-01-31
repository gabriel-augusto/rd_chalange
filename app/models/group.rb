class Group < ActiveRecord::Base
  has_many :text_queries
  has_many :numeric_queries
  belongs_to :segment

  validates_presence_of :segment
  validates_presence_of :text_queries
  validates_presence_of :numeric_queries

  validate :query_presence

  private
  def query_presence
    errors.add(:text_queries, "query should not be empty in a group") if
    self.text_queries.nil? and self.numeric_queries.nil?
  end
end
