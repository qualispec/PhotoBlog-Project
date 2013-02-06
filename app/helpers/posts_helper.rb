module PostsHelper
  def tag_links(post)
    post.tags.map do |tag|
      link_to(h(tag.name), posts_path(tag: h(tag.name)))
    end.join(', ').html_safe
  end
end
