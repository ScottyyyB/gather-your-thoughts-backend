require 'rails_helper'

RSpec.describe Thought, type: :model do
  describe 'DB Table' do
    it { is_expected.to have_db_column :id }
    it { is_expected.to have_db_column :title }
    it { is_expected.to have_db_column :body }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of :title }
    it { is_expected.to validate_presence_of :body }
  end

  describe 'Relations' do
    it { is_expected.to have_many :labels }
    it { is_expected.to have_many :sentiments }
    it { is_expected.to belong_to :user}
  end

  describe FactoryBot do
    it 'should be valid' do
      expect(FactoryBot.create(:thought)).to be_valid
    end
  end
end
