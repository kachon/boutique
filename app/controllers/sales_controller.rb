class SalesController < ApplicationController
  before_action :check_user
  skip_before_filter :verify_authenticity_token
  include BoutiqueMainHelper

  def show
    begin
      @sale = Sale.find(params[:id])
      puts "here show"
      render :json => _render_sale(@sale)
    rescue Exception => ex
      render :json => {
        :msg => ex.message
        }, :status => 400
    end
  end

  def update
    begin
      sale = Sale.find(params[:id])
      validate_create(params)
      data = params['sale']
      if !sale.update_attributes(
                      :date => data['date'],
                      :remark => data['remark'],
                      :payment => data['payment'])
        raise sale.errors.full_messages[0]
      else
        sale.items.clear
        data['items'].each do |item| 
          sale.items.create!(
              :clothing => item['clothing'],
              :unit_price => item['unit_price'])
        end
      end
      render :json => _render_sale(sale)
    rescue Exception => ex
      render :json => {
        :msg => ex.message
        }, :status => 400
    end
  end

  def create
    puts "create! #{params}"
    begin
      new_sale = nil
      validate_create(params)
      data = params['sale']
      new_sale = Sale.create!(
                    :date => data['date'],
                    :remark => data['remark'],
                    :payment => data['payment'])
      # if !new_sale.save()
      #   raise new_clothing.errors.full_messages[0]
      # end
      data['items'].each do |item| 
        new_sale.items.create!(
            :clothing => item['clothing'],
            :unit_price => item['unit_price'])
      end

      render :json => _render_sale(new_sale)
    rescue Exception => ex
      if new_sale
        new_sale.destroy
      end

      render :json => {
        :msg => ex.message
        }, :status => 400
    end
  end

  def destroy
    begin
      sale = Sale.find(params[:id])
      sale.destroy
      render :json => sale
    rescue Exception => ex
      render :json => {
        :msg => ex.message
        }, :status => 400
    end
  end

  def validate_create (params)
    if !params.has_key?('sale')
      raise 'missing sale'
    end

    sale = params['sale']
    if !sale.has_key?('date')
      raise 'missing date'
    end

    if !sale.has_key?('remark')
      raise 'missing remark'
    end

    if !sale.has_key?('payment')
      raise 'missing payment'
    end

    if !sale.has_key?('items')
      raise 'missing items'
    end

    sale['items'].each do |item| 
      if !item.has_key?('clothing')
        raise 'missing clothing'
      end

      if !item.has_key?('unit_price')
        raise 'missing unit_price'
      end
    end
  end

  private

  def _render_sale(sale)
    sale.as_json(:include => 
                  { :items =>
                    { :methods => :clothing_desc }  
                  },
                 :methods => :test
                )
  end

end
