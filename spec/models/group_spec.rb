require 'rails_helper'

RSpec.describe Group, type: :model do
  context 'When testing with valid values' do
    before(:each) do
     @segment = create_valid_segment_scenario
     @group = @segment.groups.last
    end

    it 'should create a valid object' do
      expect(@group).to be_valid
    end

    it 'should increase the Group table counter' do
      expect{
        segment = create_valid_segment_scenario
        segment.save
        @group.save
      }.to change(Group, :count).by(1)
    end

    it 'should return an valid query string' do
      text_query = @group.text_queries.last
      numeric_query = @group.numeric_queries.last
      expected_string = "#{text_query.to_s} AND #{numeric_query.to_s}"
      expect(@group.to_s).to be == expected_string
    end
  end
end
