require 'rails_helper'

RSpec.describe StoreSection, type: :model do
  describe 'validations' do
    it 'is valid with valid attribute' do
      store_section = build(:store_section)
      expect(store_section).to be_valid
    end

    it 'is not valid without a name' do
      store_section = build(:store_section, name: nil)
      expect(store_section).to_not be_valid
      expect(store_section.errors[:name]).to include("can't be blank")
    end

    it 'is not valid with a name longer than 64 characters' do
      store_section = build(:store_section, name: 'a' * 65)
      expect(store_section).to_not be_valid
      expect(store_section.errors[:name]).to include('is too long (maximum is 64 characters)')
    end

    it 'validates name format with only letters and white space' do
      store_section = build(:store_section, name: 'Valid Name')
      expect(store_section).to be_valid

      store_section.name = 'section1234'
      expect(store_section).to_not be_valid
      expect(store_section.errors[:name]).to include('only letter and white space')
    end
  end
end
