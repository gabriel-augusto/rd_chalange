class NumericQuery < ActiveRecord::Base
  include Query
  belongs_to :group

  VALID_CONTACT_ARGUMENTS =  ["Birth year"]

  validates_presence_of :contact_argument
  validates_inclusion_of :contact_argument, in: VALID_CONTACT_ARGUMENTS,
                         message: '%{value} is not a valid contact_argument'

  MIN_LIMIT = 0
  validates_numericality_of :min_value,
                            greater_than_or_equal_to: MIN_LIMIT,
                            less_than_or_equal_to: :max_value,
                            only_integer: true

  MAX_LIMIT = 3000
  validates_numericality_of :max_value,
                            less_than_or_equal_to: MAX_LIMIT,
                            greater_than_or_equal_to: :min_value,
                            only_integer: true

  def to_s
    search_limit_up = "#{contact_argument.downcase} <= #{max_value}"
    search_limit_down = "#{contact_argument.downcase} >= #{min_value}"
    return search_limit_up + " AND " + search_limit_down
  end

end
