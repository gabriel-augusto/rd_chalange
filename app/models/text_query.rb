class TextQuery < ActiveRecord::Base
  include Query
  belongs_to :group

  VALID_CONTACT_ARGUMENTS =  %w( Name Email State Position )

  validates_inclusion_of :contact_argument, in: VALID_CONTACT_ARGUMENTS
  validates_presence_of :value_to_compare
  VALUE_TO_COMPARE_MIN_LENGTH = 1   #characters
  VALUE_TO_COMPARE_MAX_LENGTH = 100  #characters
  validates_length_of :value_to_compare, in: VALUE_TO_COMPARE_MIN_LENGTH..VALUE_TO_COMPARE_MAX_LENGTH
end
