require 'rails_helper'

RSpec.describe Contact, type: :model do
  context 'When providing valid data' do
    before(:each) do
      @contact = create_contact
    end

    it 'should be an instance of Contact' do
      expect(@contact).to be_instance_of(Contact)
    end

    it 'should be saved in the database' do
      expect{
        contact = create_contact
        contact.save
      }.to change(Contact, :count).by(1)
    end

    it 'should be valid to save' do
      expect(@contact).to be_valid
    end

    it 'should increase the database' do
      expect {
        another_contact = @contact.dup
        another_contact.save
      }.to change(Contact, :count).by(1)
    end

    it 'should be valid without an position' do
      @contact.position = ''
      expect(@contact).to be_valid
    end
  end

  context 'When providing invalid data' do
    context 'Testing wrong values for name' do
      it 'should not be valid with a too small name' do
        invalid_name = 'a'*(Contact::NAME_MIN_LENGTH - 1)
        contact = create_contact({name: invalid_name})
        expect(contact).not_to be_valid
      end

      it 'should not be valid with a too long name' do
        invalid_name = 'a'*(Contact::NAME_MAX_LENGTH + 1)
        contact = create_contact({name: invalid_name})
        expect(contact).not_to be_valid
      end

      it 'should not be saved in the database' do
        invalid_name = 'a'*(Contact::NAME_MAX_LENGTH + 1)
        expect{
          contact = create_contact({name: invalid_name})
          contact.save
        }.to change(Contact, :count).by(0)
      end
    end

    context 'Testing wrong values for email' do
      it 'should not be valid without @' do
        invalid_email = 'test.test.test'
        contact = create_contact({email: invalid_email})
        expect(contact).not_to be_valid
      end

      it 'should not be valid with more than one "@"' do
        invalid_email = 'test@@test.tt'
        contact = create_contact({email: invalid_email})
        expect(contact).not_to be_valid
      end

      it 'should not be valid without username' do
        invalid_email = '@test.tt'
        contact = create_contact({email: invalid_email})
        expect(contact).not_to be_valid
      end

      it 'should not be valid without complete domain' do
        invalid_email = 'test@test.'
        contact = create_contact({email: invalid_email})
        expect(contact).not_to be_valid
      end

      it 'should not be valid only with numbers' do
        invalid_email = '12345@1234.12'
        contact = create_contact({email: invalid_email})
        expect(contact).not_to be_valid
      end
    end

    context 'Testing wrong values for the date of birth' do
      it 'should not be valid to ridiculously great ages' do
        invalid_date = Contact::TIME_LIMIT_DOWN - 1.year
        contact = create_contact({date_of_birth: invalid_date})
        expect(contact).not_to be_valid
      end

      it 'should not be valid to ridiculously young ages' do
        invalid_date = Contact::TIME_LIMIT_UP + 1.year
        contact = create_contact({date_of_birth: invalid_date})
        expect(contact).not_to be_valid
      end
    end

    context 'Testing wrong values for the state' do
      it 'should not be valid with numbers' do
        invalid_state = '12'
        contact = create_contact({state: invalid_state})
        expect(contact).not_to be_valid
      end

      it 'should not be valid with a bunch of characters' do
        invalid_state = 'AZA'
        contact = create_contact({state: invalid_state})
        expect(contact).not_to be_valid
      end

      it 'should not be valid with too short initials' do
        invalid_state = 'A'
        contact = create_contact({state: invalid_state})
        expect(contact).not_to be_valid
      end

      it 'should not be valid with non-letter characters' do
        invalid_state = '.,'
        contact = create_contact({state: invalid_state})
        expect(contact).not_to be_valid
      end

      it 'should not be valid with downcase characters' do
        invalid_state = 'df'
        contact = create_contact({state: invalid_state})
        expect(contact).not_to be_valid
      end
    end
  end
end
