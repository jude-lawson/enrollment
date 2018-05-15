require 'rails_helper'

RSpec.describe Course do
  describe 'Validations' do
    it { should validate_presence_of(:title) }
  end
end
