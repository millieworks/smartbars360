class CustomersController < AdministrationController
  authorize_resource

  def index
    @customers = Customer.sorted
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def new
    @customer = Customer.new
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def create
    @customer = Customer.new(params[:customer])

    if @customer.save
      redirect_to @customer, notice: 'Customer was successfully created.'
    else
      render "new"
    end
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update_attributes(params[:customer])
      redirect_to @customer, notice: 'Customer was successfully updated.'
    else
      render "edit"
    end
  end

  def destroy
    @customer = Customer.find(params[:id])
    if @customer.destroy
      redirect_to customers_url, notice: 'Customer was successfully deleted.'
    end
  end
end