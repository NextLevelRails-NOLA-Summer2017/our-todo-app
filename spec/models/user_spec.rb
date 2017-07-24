require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }

  it 'has a valid factory' do
    expect(user).to be_valid
  end

  it 'shows first and last name for full_name method' do
    user = User.new(firstname: 'Phil', lastname: 'McCracken')

    expect(user.full_name).to eq("Phil McCracken")
  end

  it 'is invalid without a first name' do
    user.firstname = nil

    expect(user).not_to be_valid
  end

  it 'is invalid without a last name' do
    user.lastname = nil

    expect(user.valid?).to eq(false)
  end

  it 'is invalid without an email address' do
    user.email = nil

    expect(user).not_to be_valid
  end

  it 'is invalid without a unique email address' do
    user.save
    other_user = build(:user, email: user.email)
    other_user.valid?

    expect(other_user.errors[:email]).to include('has already been taken')
  end

  it 'has two tasks' do
    expect(user.tasks.length).to eq(2)
  end

  it 'returns tasks due today' do
    task = user.tasks.first
    task.update(due_date: DateTime.now)

    expect(user.due_today.length).to eq(1)
  end
end












