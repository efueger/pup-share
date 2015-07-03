class JobsController < ApplicationController
  before_action :authenticate_user!, only: [:user_index, :new, :edit, :create, :update, :destroy, :walk_request ]
  before_action :set_job, except: [:index, :new, :create, :approve_walk_request, :deny_walk_request, :cancel_walk] 


  def index
    if params[:user_id].nil?
      @jobs = Job.all
    else
      @jobs = Job.where(user_id: params[:user_id])
    end
  end

  def show; end

  def new
    if current_user.pups.empty?
      redirect_to new_user_pup_path(current_user), alert: 'Create a pup to add to your job'
    else
      @job = Job.new
    end
  end

  def edit; end

  def create
    @job = current_user.jobs.new(job_params)

    if @job.save
      redirect_to root_path, notice: 'Job created'
    else
      render :new
    end
  end

  def update
    if @job.update(job_params)
      redirect_to root_path, notice: 'Job updated'
    else
      render :edit
    end
  end

  def destroy
    @job.send_destroyed_walk_mailer
    @job.destroy
    redirect_to root_path, notice: 'Job destroyed'
  end

  def walk_request
    @job.walk_request(current_user)
    @job.send_walk_request_mailers
    redirect_to root_path, notice: 'Request email sent'
  end

  def approve_walk_request
    @job = Job.find(params[:id]) # excluded from set_job before_action to facilitate rescue
    @job.send_approve_walk_request_mailers
    @job.approve_walk_request
    redirect_to root_path, notice: 'You approved a walk request'
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: 'Job request was cancelled or job no longer exists'
    return
  end

  def deny_walk_request
    @job = Job.find(params[:id]) # excluded from set_job before_action to facilitate rescue
    @job.send_deny_walk_request_mailers # errors out when 
    @job.deny_walk_request
    redirect_to root_path, alert: 'You denied a walk request'
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: 'Job request was cancelled or job no longer exists'
    return
  end

  def cancel_walk 
    @job = Job.find(params[:id]) # excluded from set_job before_action to facilitate rescue
    @job.send_cancel_walk_mailer
    @job.cancel_walk
    redirect_to root_path, alert: 'Walk cancelled'
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: 'Job request was cancelled or job no longer exists'
    return
  end

  private

  def set_job
    @job = Job.find(params[:id])
  end

  def job_params
    params.require(:job).permit!
  end

end