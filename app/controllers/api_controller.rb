class ApiController < ApplicationController
  NON_DATA_PARAMS = %w(user_id api_key widget_id controller action format)
  
  before_filter :find_customer_by_api_key, :set_host, :set_api_key
  before_filter :set_widget, only: [:widget, :widget_action]

  def init
    if params["url"].blank?
      render text: "Missing url", status: :not_found
    else
      @tracked_user = TrackedUser.find_or_create_by_public_user_id_and_customer_id(params["user_id"], @customer.id)
      @tracked_user.update_counters(params["visit_id"])

      TrackedUrl.add_tracked_user(params[:url], @customer.id, @tracked_user.id, request.remote_ip)

      @widget_id = SmartbarSelector.new({ url: params[:url],
                                          customer_id: @customer.id,
                                          tracked_user_id: @tracked_user.id }).get_smartbar_id
    end
  end

  def widget
    if @widget.customer_id != @customer.id
      render text: ''
    elsif !@widget.nil?
      @position = set_position
      set_js_rule
      render widget_template
    end
  end

  def widget_action
    user_id = params["user_id"]
    data = params.delete_if { |key, value| NON_DATA_PARAMS.include?(key) }
    TrackedUserAction.create_from_tracked_user_public_id_and_smartbar(user_id, @widget, data)
  end

  def user_stats
    @tracked_user = TrackedUser.find_by_public_user_id_and_customer_id(params["user_id"], @customer.id)
    respond_to do |format|
      format.json { render json: @tracked_user }
    end
  end

  private
    def find_customer_by_api_key
      @customer = Customer.find_by_api_key(params["api_key"])
      if @customer.nil?
        render js: "alert('Invalid api_key');"
      end
    end

    def set_api_key
      @api_key = params["api_key"]
    end

    def set_widget
      @widget = Smartbar.find(params[:widget_id])
    end

    def set_position
      if @widget.position_element == "body"
        if @widget.position_prepend
          return "document.body.insertBefore(widgetDiv, document.body.firstChild);"
        else
          return "document.body.appendChild(widgetDiv);"
        end
      else
        if @widget.position_prepend
          return "ender('#{@widget.position_element}').prepend(widgetDiv);"
        else
          return "ender('#{@widget.position_element}').append(widgetDiv);"
        end
      end
    end

    def set_js_rule
      js_rules = @widget.rules.collect { |rule| rule if rule.rule_type.indicator.include?("Javascript") }
      js_rule = js_rules.compact
      js_rule = js_rule.first if js_rule.is_a?(Array)
      if js_rule
        @indicator = js_rule.rule_type.indicator
        @operator = js_rule.rule_type.value_operator
        @delay = js_rule.value
      else
        @indicator = ""
      end
    end

    def widget_template
      slider = /os360-slider-(top|right|bottom|left)/.match(@widget.minified_html)

      if slider.nil?
        return 'simple_widget'
      else
        @dimension = %w(top bottom).include?(slider[1]) ? 'height' : 'width'
        return 'slider_widget'
      end
    end
end
