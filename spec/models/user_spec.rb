require 'spec_helper'

describe User do
  let(:user) { FactoryGirl.build(:user) }
  subject { user }
  it { should be_valid }

  it 'is invalid without a name' do
    user.name = nil
    user.should_not be_valid
  end

  it 'is invalid without an email' do
    user.email = nil
    user.should_not be_valid
  end

  it 'is invalid if email is already taken' do
    user.save!
    user_with_same_email = FactoryGirl.build(:user)
    user_with_same_email.email = user.email
    user_with_same_email.should_not be_valid
  end
end
