module BoutiqueMainHelper
  
  def check_user
    Rails.logger.info "check user through logger"
    puts "check user through puts"
    # need to enter code here to return error if user is not found
    # render :json => {
    #   :abc => 111,
    #   :zyx => 222
    # }
  end

end
