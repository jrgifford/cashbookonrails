class HomeController < ApplicationController
  def index
    @accounts = Account.find(:all)
  end
end
