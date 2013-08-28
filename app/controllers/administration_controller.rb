class AdministrationController < ApplicationController
  before_filter :authenticate_user!

  def index
    unless current_user.customer_id.nil?
      @download_links = TrackedUserAction.get_smartbars_with_data(current_user.id)
    end
  end

  def download
    @data = TrackedUserAction.get_csv_data(current_user.id, params[:id])

    filename ||= params[:action]
    filename += '.csv'

    if request.env['HTTP_USER_AGENT'] =~ /msie/i
      headers['Pragma'] = 'public'
      headers["Content-type"] = "text/plain"
      headers['Cache-Control'] = 'no-cache, must-revalidate, post-check=0, pre-check=0'
      headers['Content-Disposition'] = "attachment; filename=\"#{filename}\""
      headers['Expires'] = "0"
    else
      headers["Content-Type"] ||= 'text/csv'
      headers["Content-Disposition"] = "attachment; filename=\"#{filename}\""
    end

    render text: @data
  end
end
