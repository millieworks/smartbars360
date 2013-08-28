class SmartbarsWizardController < AdministrationController
  include Wicked::Wizard
  steps :templates, :markup, :style, :rules

  def show
    @smartbar = Smartbar.find(params[:smartbar_id])
    render_wizard
  end

  def update
    @smartbar = Smartbar.find(params[:smartbar_id])
    params[:smartbar][:status] = step.to_s
    params[:smartbar][:status] = 'active' if step == steps.last
    process_templates
    @smartbar.update_attributes(params[:smartbar])
    render_wizard @smartbar
  end

  def create
    @smartbar = Smartbar.create
    redirect_to wizard_path(steps.first, smartbar_id: @smartbar.id)
  end

  private
    def process_templates
      unless params[:smartbar_format_template].blank?
        format_template = SmartbarFormatTemplate.find(params[:smartbar_format_template])
        if format_template
          params[:smartbar][:html] = format_template.html
          params[:smartbar][:css] = format_template.css
        end
      end
      unless params[:smartbar_content_template].blank?
        content_template = SmartbarContentTemplate.find(params[:smartbar_content_template])
        if content_template
          params[:smartbar][:html] = params[:smartbar][:html].gsub("CONTENT", content_template.html)
          params[:smartbar][:css] << "\n#{content_template.css}"
        end
      end
    end

    def finish_wizard_path
      customer_smartbar_path current_user.customer_id, @smartbar.id
    end

    def redirect_to_finish_wizard(options = nil)
      redirect_to finish_wizard_path, notice: "Smartbar was successfully created."
    end
end
