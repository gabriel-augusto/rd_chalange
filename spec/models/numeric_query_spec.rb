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
        @query_group.save
      }.to change(NumericQuery, :count).by(1)
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

    it "should not be valid without a group" do
      numeric_query = create_numeric_query
      expect(numeric_query).not_to be_valid
    end
  end
end
