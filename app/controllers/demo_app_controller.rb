class DemoAppController < ApplicationController
  layout "demo_app"

  before_filter :set_api_key, except: [:invalid_api_key, :callback]
  before_filter :set_host, except: :callback

  def download_pdf
    send_data("#{Rails.public_path}/catalog.pdf", :filename => "catalog.pdf", :type => "application/pdf")
  end

  def invalid_api_key
    @api_key = "invalid"
  end

  private
    def set_api_key
      @api_key = Customer.find_by_name("Demo Application").api_key
    end
end