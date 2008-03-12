# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '211a5468aa8348cb4e19cefe52642a7d'
  
  ActiveScaffold.set_defaults do |config| 
    config.ignore_columns.add [:created_at, :updated_at, :lock_version]
    config.list.per_page = 10
  end  
end
