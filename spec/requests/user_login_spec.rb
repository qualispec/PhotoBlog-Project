require 'spec_helper'

describe "Signing up" do
  let(:user) { FactoryGirl.build(:user) }

  before do
    visit '/users/new'
    fill_in 'user_name', with: user.name
    fill_in 'user_email', with: user.email
  end

  it "Signing up with valid attributes" do
    expect { click_button "Sign Up" }.to change(User, :count).by(1)
  end

  context "on successful sign-up" do
    before do
      visit '/users/new'
      fill_in 'user_name', with: user.name
      fill_in 'user_email', with: user.email
      click_button "Sign Up"
    end

    it "flashes success" do
      page.should have_content "created"
    end

    it "redirects to user show page" do
      current_path.should == user_path(User.find_by_email(user.email))
    end
  end
end