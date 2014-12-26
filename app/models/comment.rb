class Comment
  include Mongoid::Document
  field :content, type: String

  embeds_many :replies
end
