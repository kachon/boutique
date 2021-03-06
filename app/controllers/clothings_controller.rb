class ClothingsController < ApplicationController
  before_action :check_user
  skip_before_filter :verify_authenticity_token
  include BoutiqueMainHelper

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
      if !clothing.update_attributes(
                      :img_link => data['img_link'],
                      :unit_price => data['unit_price'],
                      :date => data['date'])
        raise clothing.errors.full_messages[0]
      end
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
                      :img_link => data['img_link'],
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

  def destroy
    begin
      clothing = Clothing.find(params[:id])
      clothing.destroy
      render :json => clothing
    rescue Exception => ex
      render :json => {
        :msg => ex.message
        }, :status => 400
    end
  end

  def validate_create (params)
    if !params.has_key?('clothing')
      raise 'missing clothing'
    end

    clothing = params['clothing']
    if !clothing.has_key?('img_link')
      raise 'missing img_link'
    end

    if !clothing.has_key?('unit_price')
      raise 'missing unit_price'
    end

    if !clothing.has_key?('date')
      raise 'missing date'
    end
  end

end
