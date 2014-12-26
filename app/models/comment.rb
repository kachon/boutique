class Comment
  include Mongoid::Document
  field :content, type: String

  embeds_many :replies

  def test_log
    Rails.logger.info "#{to_json}"
  end
end
