class Contact < ActiveRecord::Base
  has_and_belongs_to_many :segments

  validates_presence_of :name
  NAME_MIN_LENGTH = 3   #characters
  NAME_MAX_LENGTH = 50  #characters
  validates :name, length: {in: NAME_MIN_LENGTH..NAME_MAX_LENGTH}

  validates_presence_of :email
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, format: {with: email_regex}

  validates_presence_of :date_of_birth
  TIME_LIMIT_DOWN = 100.years.ago
  TIME_LIMIT_UP = 10.years.ago
  validates_datetime :date_of_birth, after:TIME_LIMIT_DOWN
  validates_datetime :date_of_birth, before:TIME_LIMIT_UP

  validates_presence_of :state
  state_regex = /\A[A-Z]{2}\z/
  validates :state, format: {with: state_regex}

  def age
    now = Time.now.utc.to_date
    correction_factor = self.date_of_birth.to_date.change(year: now.year) > now ? 1 : 0
    now.year - self.date_of_birth.year - correction_factor
  end

end
