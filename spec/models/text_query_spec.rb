require 'rails_helper'

RSpec.describe TextQuery, type: :model do
  context 'When providing valid data' do
    before(:each) do
      @segment = create_valid_segment_scenario
      @query_group = @segment.groups.last
      @text_query = @query_group.text_queries.last
    end

    it 'should be an instance of TextQuery' do
      expect(@text_query).to be_instance_of(TextQuery)
    end

    it 'should be saved in the database' do
      expect{
        segment = create_valid_segment_scenario
        segment.save
      }.to change(TextQuery, :count).by(1)
    end

    it 'should be valid to save' do
      expect(@text_query).to be_valid
    end

    it 'should increase the database' do
      expect {
        @query_group.save
      }.to change(TextQuery, :count).by(1)
    end

    it 'should return an valid query string' do
      valid_contact_argument = 'Name' #valid
      valid_value_to_compare = 'a'*TextQuery::VALUE_TO_COMPARE_MIN_LENGTH
      @text_query.contact_argument = valid_contact_argument
      @text_query.value_to_compare = valid_value_to_compare
      expected_string = "name LIKE '#{valid_value_to_compare}%'"
      expect(text_query.to_s).to be == expected_string
    end
  end

  context 'When providing invalid data' do
    before(:each) do
      @segment = create_valid_segment_scenario
      @query_group = @segment.groups.last
      @text_query = @query_group.text_queries.last
    end

    it 'should not be valid with a too small value_to_compare' do
      invalid_value_to_compare = 'a'*(TextQuery::VALUE_TO_COMPARE_MIN_LENGTH - 1)
      @text_query.value_to_compare = invalid_value_to_compare
      expect(@text_query).not_to be_valid
    end

    it 'should not be valid with a too long value_to_compare' do
      invalid_value_to_compare = 'a'*(TextQuery::VALUE_TO_COMPARE_MAX_LENGTH + 1)
      @text_query.value_to_compare = invalid_value_to_compare
      expect(@text_query).not_to be_valid
    end

    it 'should not be valid without a value_to_compare' do
      invalid_value_to_compare = nil
      @text_query.value_to_compare = invalid_value_to_compare
      expect(@text_query).not_to be_valid
    end

    it 'should not be saved in the database' do
      invalid_value_to_compare =  'a'*(TextQuery::VALUE_TO_COMPARE_MAX_LENGTH + 1)
      expect{
        text_query = create_text_query({
          value_to_compare: invalid_value_to_compare
        })
        text_query.save
      }.to change(TextQuery, :count).by(0)
    end

    it 'should not be valid without a group' do
      text_query = create_text_query
      expect(text_query).not_to be_valid
    end
  end
end
