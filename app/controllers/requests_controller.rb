class RequestsController < ApplicationController
  before_action :authenticate_user!, except: [:edit]
  before_action :set_request, only: [:show, :update, :destroy]

  def index; end

  def show; end

  def new
    @request = Request.new
  end

  def edit
    @request = Request.find(params[:id]) # allows rescue for destroyed requests
    @request.update status: params[:status]
    redirect_to root_path(current_user, status:'approved'), notice: @request.send_request_mailers
  rescue ActiveRecord::RecordNotFound
    redirect_to user_requests_path(current_user), alert: 'Sorry. The request or job no longer exists'   
  end

  def create
    @request = current_user.requests.create(request_params)
    @request.send_request_mailers
    flash[:notice] = 'Request sent! Check your dashboard'
    redirect_to(:back)
  end

  # email does not support :post requests
  # def update
  #   if @request.update(request_params)
  #     redirect_to user_requests_path(current_user), notice: 'Request updated'
  #   else
  #     render :edit
  #   end
  # end

  def destroy
    @request.destroy
    redirect_to user_requests_path(current_user)
  end

  private

  def set_request
    @request = Request.find(params[:id])
  end

  def request_params
    params.require(:request).permit!
  end
end
