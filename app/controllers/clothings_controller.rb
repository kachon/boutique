class ClothingsController < ApplicationController
  before_action :check_user
  skip_before_filter :verify_authenticity_token

  def show
    begin
      @clothing = Clothing.find(params[:id])
      render :json => @clothing
    rescue Exception => ex
      render :json => {
        :msg => ex.message
        }, :status => 400
    end
  end

  def update
    begin
      clothing = Clothing.find(params[:id])
      validate_create(params)
      data = params['clothing']
      puts "1"
      if !clothing.update_attributes(
                      :desc => data['desc'],
                      :unit_price => data['unit_price'],
                      :date => data['date'])
        raise clothing.errors.full_messages[0]
      end
      puts "2"
      render :json => clothing
    rescue Exception => ex
      render :json => {
        :msg => ex.message
        }, :status => 400
    end
  end

  def create
    puts "#{params}"
    begin
      validate_create(params)
      data = params['clothing']
      new_clothing = Clothing.new(
                      :desc => data['desc'],
                      :unit_price => data['unit_price'],
                      :date => data['date'])
      if !new_clothing.save()
        raise new_clothing.errors.full_messages[0]
      end
      render :json => new_clothing
    rescue Exception => ex
      render :json => {
        :msg => ex.message
        }, :status => 400
    end
  end

  def check_user
      # need to enter code here to return error if user is not found
      # render :json => {
      #   :abc => 111,
      #   :zyx => 222
      # }
  end

  def validate_create (params)
    if !params.has_key?('clothing')
      raise 'missing clothing'
    end

    clothing = params['clothing']
    if !clothing.has_key?('desc')
      raise 'missing desc'
    end

    if !clothing.has_key?('unit_price')
      raise 'missing unit_price'
    end

    if !clothing.has_key?('date')
      raise 'missing date'
    end
  end

end
