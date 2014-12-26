module BSON
  class ObjectId
    Rails.logger.info "Object Id??"
    puts "puts Object Id"
    def as_json(options = {})
      to_s
    end
  end
end
