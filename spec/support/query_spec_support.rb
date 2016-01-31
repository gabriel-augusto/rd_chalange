module QueryHelper
  # Default settings to testing.
  # Only valid data.
  def create_text_query(options = {})
    TextQuery.create({
        value_to_compare: 'a'*TextQuery::VALUE_TO_COMPARE_MIN_LENGTH,
        contact_argument: TextQuery::VALID_CONTACT_ARGUMENTS.first
    }.merge(options))
  end

  def create_numeric_query(options = {})
    NumericQuery.create({
        min_value: NumericQuery::MIN_LIMIT,
        max_value: NumericQuery::MAX_LIMIT,
        contact_argument: NumericQuery::VALID_CONTACT_ARGUMENTS.first
    }.merge(options))
  end
end
