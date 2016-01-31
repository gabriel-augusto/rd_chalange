class NumericQuery < ActiveRecord::Base
  include Query
  belongs_to :group

  VALID_CONTACT_ARGUMENTS =  %w( age )

  validates_presence_of :group
  validates_presence_of :contact_argument
  validates_inclusion_of :contact_argument, in: %w(age), message: '%{value} is not a valid contact_argument'

  MIN_LIMIT = 0
  validates_numericality_of :min_value,
                            greater_than_or_equal_to: MIN_LIMIT,
                            less_than_or_equal_to: :max_value,
                            only_integer: true

  MAX_LIMIT = 110
  validates_numericality_of :max_value,
                            less_than_or_equal_to: MAX_LIMIT,
                            greater_than_or_equal_to: :min_value,
                            only_integer: true
end
