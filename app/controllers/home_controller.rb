
class HomeController < ApplicationController
  def index
    redirect_to "/#{SecureRandom.hex(16)}"
  end
  def show
  
  end
end