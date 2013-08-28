class SmartbarsController < AdministrationController
  authorize_resource

  def index
    @smartbars = Smartbar.find_all_by_customer_id(current_user.customer_id, order: "name ASC")
  end

  def new
    @customer = Customer.find(current_user.customer_id)
    @smartbar = Smartbar.new
  end

  def show
    @smartbar = SmartbarDecorator.find(params[:id])
  end

  def edit
    @customer = Customer.find(current_user.customer_id)
    @smartbar = Smartbar.find(params[:id])
  end

  def create
    @smartbar = Smartbar.new(params[:smartbar])

    if @smartbar.save
      redirect_to smartbar_build_index_path(@smartbar.id)
    else
      render "new"
    end
  end

  def update
    @smartbar = Smartbar.find(params[:id])

    if @smartbar.update_attributes(params[:smartbar])
      redirect_to @smartbar, notice: 'Smartbar was successfully updated.'
    else
      render "edit"
    end
  end

  def destroy
    @smartbar = Smartbar.find(params[:id])
    if @smartbar.destroy
      redirect_to customer_smartbars_url(current_user.customer_id), notice: 'Smartbar was successfully deleted.'
    end
  end
end
