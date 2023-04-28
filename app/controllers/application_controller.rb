class ApplicationController < ActionController::Base
  include Pundit::Authorization

  rescue_from Pundit::NotAuthorizedError do
    flash[:danger] = 'You do not have permission to access this page.'
    redirect_to root_url
  end

  rescue_from ActiveRecord::RecordNotFound do
    flash[:notice] = 'Something went Wrong...'
    redirect_to root_url
  end

  rescue_from ActiveRecord::RecordNotDestroyed do
    flash[:notice] = 'Something went Wrong...'
    redirect_to root_url
  end
end
