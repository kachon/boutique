class BoutiqueMainController < ApplicationController
  before_action :authenticate_user!, only: [:home]
  
  def home
  end
  
  def dropbox
  end

  def angular
    render layout: "applicationangular"
  end
end
