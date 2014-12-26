class Reply
  include Mongoid::Document
  field :content, type: String

  embedded_in :comment
end
