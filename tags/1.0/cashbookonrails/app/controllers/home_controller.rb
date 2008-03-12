class HomeController < ApplicationController
  layout "application"
  def index
    @accounts = Account.find(:all)
  end
end
