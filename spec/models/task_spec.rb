require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'Task Model tests' do
    context 'validations' do
      it { should validate_presence_of(:name) }
    end
    context 'associations' do
      it { should belong_to(:user).class_name('User').optional }
    end
  end
end
