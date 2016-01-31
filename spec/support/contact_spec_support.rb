module ContactHelper
  # Default settings to testing.
  # Only valid data.
  def create_contact(options = {})
    Contact.create({
                       name:             'a'*Contact::NAME_MIN_LENGTH,
                       email:            'email@email.com',
                       date_of_birth:    100.years.ago,
                       state:            'DF'
                    }.merge(options))
  end
end