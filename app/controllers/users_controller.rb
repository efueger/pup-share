class UsersController < ApplicationController
  before_action :set_user, only: [:show, :upcoming_walks, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show
    @pups = current_user.pups
    @availabilities = current_user.availabilities
    @jobs = current_user.jobs
  end

  def new
    @user = User.new
  end

  def edit; end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to users_path(current_user), notice: 'User created'
    else
      render :new
    end
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'User was successfully updated'
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to root_path, notice: 'Account deleted. Sorry to see you go'
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit!
  end
end
