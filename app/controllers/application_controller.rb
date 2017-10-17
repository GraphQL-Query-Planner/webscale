class ApplicationController < ActionController::Base
  # Requires api auth
  protect_from_forgery with: :exception
end
