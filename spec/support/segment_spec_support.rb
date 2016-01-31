module SegmentHelper
  # Creates a valid Segment object without any group registered
  def create_segment(options = {})
    Segment.create({
      title: "a"*Segment::TITLE_MIN_LENGTH
    }.merge(options))
  end

  # Creates a valid scenario with segment, group and query
  def create_valid_segment_scenario(segment_options: {},
                                    group_options: {},
                                    text_query_options: {},
                                    numeric_query_options: {})

    segment = create_segment(segment_options) #A valid segment without group
    group = create_group(group_options) #A valid group withou segment ans queries
    text_query = create_text_query(text_query_options) #A valid query without group
    numeric_query = create_numeric_query(numeric_query_options)
    group.text_queries << text_query
    group.numeric_queries << numeric_query
    segment.groups << group

    return segment
  end
end
