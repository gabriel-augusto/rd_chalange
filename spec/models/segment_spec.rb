require 'rails_helper'

RSpec.describe Segment, type: :model do
  context 'When providing valid data' do
    before(:each) do
      @segment = create_valid_segment_scenario
      @group = @segment.groups.last
    end

    it 'should be valid' do
      expect(@segment).to be_valid
    end

    it 'should increase the database' do
      expect{
        segment = create_valid_segment_scenario
        segment.save
      }.to change(Segment, :count).by(1)
    end

    it 'should be valid with valid title' do
      valid_title = 'a'*Segment::TITLE_MAX_LENGTH
      @segment.title = valid_title
      expect(@segment).to be_valid
    end

    it 'should return an valid query string' do
      text_query = TextQuery.new(contact_argument: "position", value_to_compare: "student")
      group = Group.new
      group.text_queries << text_query
      @segment.groups << group
      expected_string = "#{@group.to_s} OR #{group.to_s}"
      expect(@segment.to_s).to be == expected_string
    end
  end

  context 'When providing invalid data' do
    before(:each) do
      @segment = create_valid_segment_scenario
    end

    it 'should not be valid with too long titles' do
      invalid_title = 'a'*(Segment::TITLE_MAX_LENGTH + 1)
      @segment.title = invalid_title
      expect(@segment).not_to be_valid
    end

    it 'should not be valid with too short titles' do
      invalid_title = 'a'*(Segment::TITLE_MIN_LENGTH - 1)
      @segment.title = invalid_title
      expect(@segment).not_to be_valid
    end

    it 'should not increase the database table counter' do
      invalid_title = 'a'*(Segment::TITLE_MIN_LENGTH - 1)
      expect{
        segment = create_valid_segment_scenario(
          segment_options: {
            title: invalid_title
          }
        )
        segment.save
      }.to change(Segment, :count).by(0)
    end
  end
end
