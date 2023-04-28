require 'rails_helper'

RSpec.describe User, type: :model do
  subject { FactoryBot.build(:user) }

  describe 'associations' do
    it { is_expected.to have_many(:tasks).dependent(:destroy) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email).ignoring_case_sensitivity }
    it { is_expected.to allow_value('user@example.com').for(:email) }
    it { is_expected.to_not allow_value('invalid_email').for(:email) }
    it { is_expected.to validate_presence_of(:role) }

    describe '#verify_email_domain' do
      context 'when email has a gmail, hotmail, or yahoo domain' do
        it 'adds an error to the email attribute' do
          subject.email = 'user@gmail.com'
          subject.valid?
          expect(subject.errors[:email]).to include('cannot have the gmail, hotmail, or yahoo domain')
        end
      end

      context 'when email does not have a gmail, hotmail, or yahoo domain' do
        it 'does not add an error to the email attribute' do
          subject.email = 'user@example.com'
          subject.valid?
          expect(subject.errors[:email]).to_not include('cannot have the gmail, hotmail, or yahoo domain')
        end
      end
    end
  end

  describe 'enums' do
    it { is_expected.to define_enum_for(:role).with_values(admin: 0, team_mate: 1) }
  end

  describe 'scopes' do
    describe '.except_user' do
      let!(:current_user) { FactoryBot.create(:user) }
      let!(:other_users) { FactoryBot.create_list(:user, 3) }

      it 'returns all users except the current user' do
        expect(User.except_user(current_user)).to match_array(other_users)
      end
    end
  end

  describe 'callbacks' do
    describe '#update_username' do
      context 'when the first name is blank' do
        it 'updates the first name with the first two characters of the email address in uppercase' do
          subject.first_name = nil
          subject.email = 'user@example.com'
          subject.save
          expect(subject.first_name).to eq('US')
        end
      end

      context 'when the first name is not blank' do
        it 'does not update the first name' do
          subject.first_name = 'John'
          subject.email = 'user@example.com'
          subject.save
          expect(subject.first_name).to eq('John')
        end
      end
    end
  end

  describe 'validations' do
    subject { build(:user) }

    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).ignoring_case_sensitivity }
    it { should_not allow_value('example@').for(:email) }
    it { should_not allow_value('example.com').for(:email) }
    it { should_not allow_value('example@com').for(:email) }

    it { should validate_presence_of(:role) }
    it { should define_enum_for(:role).with_values(admin: 0, team_mate: 1) }

    context 'when email domain is gmail.com, hotmail.com or yahoo.com' do
      it 'is not valid' do
        user = build(:user, email: 'example@gmail.com')
        user.valid?
        expect(user.errors[:email]).to include('cannot have the gmail, hotmail, or yahoo domain')
      end
    end
  end

  describe 'callbacks' do
    describe '#update_username' do
      context 'when first_name is blank' do
        it 'updates the first_name' do
          user = create(:user, email: 'example@example.com', first_name: '')
          expect(user.first_name).to eq('EX')
        end
      end

      context 'when first_name is not blank' do
        it 'does not update the first_name' do
          user = create(:user, email: 'example@example.com', first_name: 'John')
          expect(user.first_name).to eq('John')
        end
      end
    end
  end

  describe 'associations' do
    it { should have_many(:tasks).dependent(:destroy) }
  end

  describe 'devise' do
    it { should validate_presence_of(:password).on(:create) }
    it { should validate_length_of(:password).is_at_least(6).on(:create) }
    it { should validate_confirmation_of(:password) }
    it { should allow_value('password123').for(:password) }
  end
end
