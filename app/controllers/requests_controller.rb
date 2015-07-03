class RequestsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_request, only: [:show, :edit, :update, :destroy]

  def index
    if params[:status] == 'approved'
      @requests = current_user.requests.where(status:'approved')
    else
      @requests = current_user.requests
    end
  end

  def show; end

  def new
    @request = Request.new
  end

  def edit; end

  def create
    @request = Request.new(request_params)

    if @request.save
      redirect_to user_requests_path, notice: 'Request created'
    else
      render :new
    end
  end

  def update
    if @request.update(request_params)
      redirect_to @request, notice: 'Request updated'
    else
      render :edit
    end
  end

  def destroy
    @request.destroy
    redirect_to user_requests_path(current_user), notice: 'Request destroyed'
  end

  private

  def set_request
    @request = Request.find(params[:id])
  end

  def request_params
    params.require(:request).permit!
  end
end
