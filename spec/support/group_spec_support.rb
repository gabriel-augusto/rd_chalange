module GroupHelper
  # Creates a valid group without queries and segment.
  # This method already implements a way to customize
  # the object group, even if it does not already have attributes
  def create_group(options = {})
    Group.create
  end
end
