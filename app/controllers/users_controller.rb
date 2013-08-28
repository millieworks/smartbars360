class UsersController < ApplicationController
  authorize_resource

  def index
    @users = UserDecorator.decorate(User.sorted)
  end

  def show
    @user = UserDecorator.find params[:id]
  end

  def new
    @user = User.new
  end

  def edit
    @user = UserDecorator.find params[:id]
  end

  def create
    @user = User.new_with_generated_password(params[:user])
    if @user.save
      RegistrationMailer.welcome(@user, @user.password).deliver
      redirect_to users_url, notice: 'User was successfully created.'
    else
      render "new"
    end
  end

  def update
    # required for settings form to submit when password is left blank
    #if params[:user][:password].blank?
    #  params[:user].delete("password")
    #  params[:user].delete("password_confirmation")
    #end
    @user = User.find(params[:id])
    if @user.update_without_password(params[:user])
      redirect_to users_url, notice: 'User was successfully updated.'
    else
      render "edit"
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      redirect_to users_url, notice: 'User was successfully deleted.'
    end
  end
end
