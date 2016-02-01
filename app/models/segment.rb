class Segment < ActiveRecord::Base
  has_and_belongs_to_many :contacts
  has_many :groups

  validates_associated :groups
  # Make queries editable through the groups
  accepts_nested_attributes_for :groups, reject_if: :all_blank, allow_destroy: true

  #validates_presence_of :groups
  validates_presence_of :title
  TITLE_MIN_LENGTH = 1    #characters
  TITLE_MAX_LENGTH = 100  #characters
  validates_length_of :title, in: TITLE_MIN_LENGTH..TITLE_MAX_LENGTH

  def to_s
    query = ""
    self.groups.each do |group|
      query += group.to_s
      unless self.groups.last == group
        query += " OR "
      end
    end
    return query
  end

  def update_contacts
    self.contacts.clear
    contacts = Contact.where(self.to_s)
    contacts.each do |contact|
      self.contacts << contact
    end
    self.save
  end
end
