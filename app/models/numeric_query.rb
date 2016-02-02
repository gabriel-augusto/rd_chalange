class NumericQuery < ActiveRecord::Base
  include Query
  belongs_to :group

  VALID_DATABASE_CONTACT_ARGUMENTS =  {date_of_birth: "Age"}
  VALID_CONTACT_ARGUMENTS = VALID_DATABASE_CONTACT_ARGUMENTS.values

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
    if contact_argument == "Age"
      age_query_to_s
    else
      raise QueryErrors::InvalidQueryArgument, "Invalid Contact Argument: #{contact_argument}"
    end
  end

  def age_query_to_s
    column_name = find_table_column_name(self.contact_argument)
    date_limit_up = age_to_datetime(self.min_value)
    date_limit_down = age_to_datetime(self.max_value)
    search_limit_up = column_name + " <= '#{date_limit_up}%'"
    search_limit_down = column_name + " >= '#{date_limit_down}%'"
    return (search_limit_up + " AND " + search_limit_down)
  end

  # Commented for tests
  # private

  def find_table_column_name(contact_argument)
    if VALID_CONTACT_ARGUMENTS.include? contact_argument
      VALID_DATABASE_CONTACT_ARGUMENTS.key(contact_argument).to_s
    else
      raise QueryErrors::InvalidQueryArgument, "Invalid Contact Argument: #{contact_argument}"
   end
  end

  def age_to_datetime(age)
    current_date = DateTime.now
    year_of_age = current_date.year - age
    current_date.change(year: year_of_age)
  end
end
