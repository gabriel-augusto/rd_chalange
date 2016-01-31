class Group < ActiveRecord::Base
  has_many :text_queries, dependent: :destroy
  has_many :numeric_queries, dependent: :destroy
  belongs_to :segment

  validates_associated :numeric_queries
  validates_associated :text_queries
  # Make queries editable through the groups
  accepts_nested_attributes_for :numeric_queries, allow_destroy: true
  accepts_nested_attributes_for :text_queries, allow_destroy: true
end
