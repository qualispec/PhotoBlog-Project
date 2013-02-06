require 'spec_helper'

describe 'Making posts' do
  let(:user) { FactoryGirl.create(:user) }

  before do
    visit user_path(user)
    fill_in 'post_url', :with => "http://1.bp.blogspot.com/-wvFNX3VitBc/TVqznx9X_YI/AAAAAAAAAuc/srwDIMNnCYE/s1600/capybara2.jpg"
  end

  it 'allows a user to enter a photo url' do
    expect { click_button "Add Photo" }.to change(Post, :count).by(1)
  end
end

describe 'Show posts' do
  let(:user) { FactoryGirl.create(:user) }

  before do
    10.times { user.posts << FactoryGirl.create(:post) }
    visit user_path(user)
  end

  it 'displays all photos on the user page' do
    page.should have_content('Hello, Kitty')
    page.should have_css('img', count: user.posts.count)
  end

end

describe 'Add tags' do
  let(:user) { FactoryGirl.create(:user) }

  before do
    10.times { user.posts << FactoryGirl.create(:post) }
    visit user_path(user)
  end

  it 'allows user to click a photo to edit' do
    id = user.posts.last.id
    click_link "photo_#{id}"
    current_path.should == edit_post_path(id)
  end

  it 'should allow adding tags' do
    visit edit_post_path(user.posts.last)
    fill_in 'tag_name', :with => "tag1"
    click_button 'Add Tag'
    user.posts.last.tags.map(&:name).should include('tag1')
  end

  it 'should display added tags' do
    user.posts.last.tags << FactoryGirl.create(:tag)
    visit edit_post_path(user.posts.last)
    page.should have_content('test_tag')
  end
end

describe 'XXXX' do
  let(:user) { FactoryGirl.create(:user) }
  let(:tag) { FactoryGirl.create(:tag) }

  before do
    10.times { user.posts << FactoryGirl.create(:post) }
    user.posts[0..4].each do |post|
      post.tags << tag
    end
  end

  describe 'Update photo information' do
    it 'updates photo info' do
      visit edit_post_path(user.posts.last)
      fill_in "post_body", :with => "goodbye"
      click_button "Update Photo"
      current_path.should == edit_post_path(user.posts.last)
      user.reload.posts.last.body.should == "goodbye"
    end
  end

  describe 'Delete posts' do
    it 'deletes the post when delete post button is clicked' do
      visit edit_post_path(user.posts.last)
      expect { click_button 'Delete Post' }.to change(Post, :count).by(-1)
    end
  end

  describe 'View tagged posts' do
    it 'displays all posts tagged with the clicked tag' do
      visit user_path(user)
      click_link 'test_tag'
      current_path.should == posts_path
      page.should have_css('img', count: 5)
    end
  end

  describe 'liking posts' do
    it 'allows a user to like a post' do
      visit posts_path
      post = user.posts.last
      expect { click_button "like_post_#{post.id}" }.to change { post.reload.likes }.by(1)
      current_path.should == posts_path
    end

    it 'ranks by number of likes if most popular is clicked' do
      visit posts_path
      5.times { click_button "like_post_#{Post.last.id}" }
      4.times { click_button "like_post_#{Post.first.id}" }
      click_link 'Most Popular'
      page.body.should =~ Regexp.new(".*like_post_#{Post.first.id}.*like_post_#{Post.last.id}")
    end
  end
end