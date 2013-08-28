class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access denied."
    redirect_to root_url
  end

  private
    def set_host
      @host_with_scheme_and_port = params["host"] || "#{request.scheme}://#{request.host_with_port}"
    end
end
