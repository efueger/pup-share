class JobsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy, :walk_request ]
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
      redirect_to user_path(current_user), notice: 'Job created'
    else
      render :new
    end
  end

  def update
    if @job.update(job_params)
      redirect_to user_path(current_user), notice: 'Job updated'
    else
      render :edit
    end
  end

  def destroy
    @job.destroy
    redirect_to user_path(current_user), notice: 'Job destroyed'
  end

  private

  def set_job
    @job = Job.find(params[:id])
  end

  def job_params
    params.require(:job).permit!
  end

end