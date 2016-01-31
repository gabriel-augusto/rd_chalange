class Segment < ActiveRecord::Base
  has_and_belongs_to_many :contacts
  has_many :groups, dependent: :destroy

  validates_associated :groups
  # Make queries editable through the groups
  accepts_nested_attributes_for :groups, reject_if: :all_blank, allow_destroy: true

  #validates_presence_of :groups
  validates_presence_of :title
  TITLE_MIN_LENGTH = 1    #characters
  TITLE_MAX_LENGTH = 100  #characters
  validates_length_of :title, in: TITLE_MIN_LENGTH..TITLE_MAX_LENGTH
end
