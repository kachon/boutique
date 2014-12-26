# Load the Rails application.
require File.expand_path('../application', __FILE__)

ActiveSupport::Inflector.inflections do |inflect|
  inflect.singular("reply", "replies")
end

# Initialize the Rails application.
Boutique::Application.initialize!
