require './models/post'

class PostController
  def initialize(model = Post)
    @model = model
  end

  def post!(post_data)
    post = @model.new(post_data)
    post.save
  end
end
