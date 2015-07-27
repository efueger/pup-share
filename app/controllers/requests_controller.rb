class RequestsController < ApplicationController
  before_action :authenticate_user!, except: [:edit]
  before_action :set_request, only: [:show, :update, :destroy]

  def index; end

  def show; end

  def new
    @request = Request.new
  end

  def create
    @request = current_user.requests.create(request_params)
    @request.walk_request
    flash[:notice] = 'Request sent! Check your dashboard'
    redirect_to(:back)
  end

  def edit # facilitates mailer links
    @request = Request.find(params[:id]) # allows rescue for destroyed requests
    @request.update status: params[:status]
    if params[:status] == 'approved'
      @request.approve_walk_request
      redirect_to user_path(current_user), notice: 'Request approved'
    elsif params[:status] == 'declined'
      @request.deny_walk_request
      redirect_to user_path(current_user), notice: 'Request declined'
    elsif params[:status] == 'cancelled'
      @request.cancel_walk
      @request.destroy
      redirect_to user_path(current_user), alert: 'Walk cancelled'
    end
  rescue ActiveRecord::RecordNotFound
    redirect_to user_path(current_user), alert: 'Sorry. The walk no longer exists'   
  end

  # email does not support :post requests
  # def update; end

  def destroy # redundant functionality with #edit 
    # @request.cancel_walk
    @request.destroy
    redirect_to user_path(current_user), alert: 'Walk cancelled'
  end

  private

  def set_request
    @request = Request.find(params[:id])
  end

  def request_params
    params.require(:request).permit!
  end
end
