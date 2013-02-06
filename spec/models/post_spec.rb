require 'spec_helper'

describe Post do
  let(:post) { FactoryGirl.build(:post) }
  subject { post }

  it 'should not be valid if no url and no body' do
    post.url = nil
    post.body = nil
    post.should_not be_valid
  end

  it 'should be valid if url but no body' do
    post.body = nil
    post.should be_valid
  end

  it 'should be valid if body but no url' do
    post.url = nil
    post.should be_valid
  end

  it 'should not be valid if url is not a photo url' do
    post.url = "http://www.google.com"
    post.should_not be_valid
  end
end
