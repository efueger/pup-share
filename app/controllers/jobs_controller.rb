class JobsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :set_job, except: [:index, :new, :create] 
  # after_create :set_job_pick_up_time, only: [:create]
  
  def index
    @jobs = Job.all
  end

  def show; end

  def new
    if current_user.pups.empty?
      redirect_to new_user_pup_path(current_user), alert: 'Create a pup to add to your job'
    else
      @job = Job.new
    end
  end

  def edit # facilitates mailer links
    redirect_to jobs_path, notice: @job.update_follow_up_attr(params[:feedback]) 
  end

  def create
    @job = current_user.jobs.new(job_params)
    @job.update_attributes(pick_up_time: @job.drop_off_time + @job.walk_duration * 60)
    if @job.save
      redirect_to jobs_path, notice: 'Job created'
    else
      render :new
    end
  end

  def update
    if @job.update(job_params)
      # TODO: tuck this logic into the model: job.message
      if params[:job][:hidden]
        redirect_to user_path(current_user), alert: 'Walk cancelled'
      else
        redirect_to user_path(current_user), notice: 'Job updated'
      end
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

  # def set_job_pick_up_time 
  # end

  def job_params
    params.require(:job).permit!
  end

end