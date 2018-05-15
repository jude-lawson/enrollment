require 'rails_helper'

RSpec.describe Student do
  describe 'Validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
  end

  describe 'Relationships' do
    it { should have_many(:addresses) }
  end
end
