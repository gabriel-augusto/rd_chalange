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
      }.to change(Group, :count).by(1)
    end
  end

  context 'When testing with invalid values' do
    it 'should not be valid without segment' do
      text_query = create_text_query
      group = create_group
      group.text_queries << text_query
      expect(group).not_to be_valid
    end

    it 'should not be valid without any query' do
      segment = create_segment
      group = create_group
      segment.groups << group
      expect(group).not_to be_valid
    end

    it 'should not increase the database table counter' do
      expect{
        segment = create_segment
        group = create_group
        segment.groups << group
        segment.save
        group.save
      }.to change(Group, :count).by(0)
    end
  end
end
