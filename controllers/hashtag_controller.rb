require './models/hashtag'
require './helpers/parser'

class HashtagController
  include Parser

  def initialize(model = Hashtag)
    @model = model
  end

  def trending_hashtags
    trending_hashtags = @model.trending
    [200, to_json_arr(trending_hashtags)]
  end
end
