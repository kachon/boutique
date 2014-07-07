class ClothingsController < ApplicationController
  before_action :check_user
  skip_before_filter :verify_authenticity_token

  def show
    @clothing = Clothing.find(params[:id])
    #render :json => @clothing, :only => [:id, :desc, :unit_price]
    render :json => @clothing
  end

  def create
    puts "#{params}"
    render :json => {
        :abc => 123,
        :zyx => 333
      }
  end

  def check_user
      # need to enter code here to return error if user is not found
      # render :json => {
      #   :abc => 111,
      #   :zyx => 222
      # }
  end
end
