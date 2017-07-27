require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build_stubbed(:user) }
  let(:user_with_tasks) { build(:user_with_tasks) }

  it 'has a valid factory' do
    expect(user).to be_valid
  end

end
