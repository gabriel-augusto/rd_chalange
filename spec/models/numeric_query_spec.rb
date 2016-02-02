require 'rails_helper'

RSpec.describe NumericQuery, type: :model do
  context 'When providing valid data' do
    before(:each) do
      @segment = create_valid_segment_scenario
      @query_group = @segment.groups.last
      @numeric_query = @query_group.numeric_queries.last
    end

    it 'should be an instance of NumericQuery' do
      expect(@numeric_query).to be_instance_of(NumericQuery)
    end

    it 'should be saved in the database' do
      expect{
        segment = create_valid_segment_scenario
        segment.save
      }.to change(NumericQuery, :count).by(1)
    end

    it 'should be valid to save' do
      expect(@numeric_query).to be_valid
    end

    it 'should increase the database' do
      expect {
        new_numeric_query = create_numeric_query
        new_numeric_query.save
      }.to change(NumericQuery, :count).by(1)
    end

    it 'should convert year correctly' do
      age = 15
      date_to_compare = @numeric_query.age_to_datetime(age)
      year_to_compare = DateTime.now.year - age
      correct_date = DateTime.now.change(year: year_to_compare)
      correct_date_str = correct_date.strftime("%m/%d/%Y")
      expect(date_to_compare.strftime("%m/%d/%Y")). to be == correct_date_str
    end

    it 'should return correct database table column name' do
      contact_argument = "Age"
      response = @numeric_query.find_table_column_name(contact_argument)
      expected_response = "date_of_birth"
      expect(response).to be == expected_response
    end

    it 'should return an valid query string' do
      valid_contact_argument = "Age" # valid
      valid_min_value = NumericQuery::MIN_LIMIT
      valid_max_value = NumericQuery::MAX_LIMIT
      @numeric_query.contact_argument = valid_contact_argument
      @numeric_query.min_value = valid_min_value
      @numeric_query.max_value = valid_max_value

      query_regex = /\A([A-Za-z_]+\s[<=>]{1,2}\s'[0-9-]+T[0-9:]+-[0-9:]+%'|\sAND\s){3}\z/
      expect(@numeric_query.to_s).to match(query_regex)
    end
  end

  context 'When providing invalid data' do
    before(:each) do
      @segment = create_valid_segment_scenario
      @query_group = @segment.groups.last
      @numeric_query = @query_group.numeric_queries.last
    end

    it 'should not be valid with a too small min_value' do
      invalid_min_value = NumericQuery::MIN_LIMIT - 1
      @numeric_query.min_value = invalid_min_value
      expect(@numeric_query).not_to be_valid
    end

    it 'should not be valid with a too long min_value' do
      invalid_min_value = NumericQuery::MAX_LIMIT + 1
      @numeric_query.min_value = invalid_min_value
      expect(@numeric_query).not_to be_valid
    end

    it 'should not be valid with a too small max_value' do
      invalid_max_value = NumericQuery::MIN_LIMIT - 1
      @numeric_query.min_value = invalid_max_value
      expect(@numeric_query).not_to be_valid
    end

    it 'should not be valid with a too long min_value' do
      invalid_max_value = NumericQuery::MAX_LIMIT + 1
      @numeric_query.max_value = invalid_max_value
      expect(@numeric_query).not_to be_valid
    end

    it 'should raise an error with wrong contact argument value' do
      invalid_contact_argument = "Date" # Invalid
      expect{
        @numeric_query.find_table_column_name(invalid_contact_argument)
      }.to raise_error
    end

    it 'should not be saved in the database' do
      invalid_min_value = nil
      invalid_max_value = nil

      expect{
        numeric_query = create_numeric_query({
                min_value: invalid_min_value,
                max_value: invalid_max_value
            })
        numeric_query.save
      }.to change(NumericQuery, :count).by(0)
    end
  end
end
