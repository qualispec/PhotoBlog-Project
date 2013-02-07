class TagsController < ApplicationController

  def create
    tag = Tag.find_or_create_by_name(params[:tag][:name])
    post = Post.find(params[:post_id])
    Tagging.create(tag_id: tag.id, post_id: params[:post_id])
    redirect_to post_path(post)
  end
end
