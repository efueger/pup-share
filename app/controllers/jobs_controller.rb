class JobsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :walk_request, :approve_walk_request, :deny_walk_request]
  before_action :set_job, only: [:show, :edit, :update, :destroy, :walk_request, :approve_walk_request, :deny_walk_request, :cancel_walk]

  def index
    @jobs = Job.all
  end

  def show
  end

  def new
    @job = Job.new
  end
  
  def edit
  end

  def create
    @job = current_user.jobs.new(job_params)

    respond_to do |format|
      if @job.save
        format.html { redirect_to root_path, notice: 'Job created' }
        format.json { render :show, status: :created, location: @job }
      else
        format.html { render :new }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  def walk_request
    @job.walk_request(current_user) # walker
    @job.send_walk_request_mailers
    redirect_to root_path, notice: 'Request email sent'
  end

  def approve_walk_request
    @job.send_approve_walk_request_mailers
    @job.approve_walk_request
    redirect_to root_path, success: 'You approved a Walk request'      
  end

  def deny_walk_request
    @job.send_deny_walk_request_mailers
    @job.deny_walk_request
    redirect_to root_path, alert: 'You denied a walk request'
  end

  def cancel_walk 
    @job.send_cancel_walk_mailer
    @job.cancel_walk
    redirect_to root_path, alert: 'Walk cancelled' 
  end

  def update
    respond_to do |format|
      if @job.update(job_params)
        format.html { redirect_to root_path, notice: 'Job updated' }
        format.json { render :show, status: :ok, location: @job }
      else
        format.html { render :edit }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @job.destroy
    respond_to do |format|
      format.html { redirect_to jobs_url, notice: 'Job destroyed' }
      format.json { head :no_content }
    end
  end

  private

  def set_job
    @job = Job.find(params[:id])
  end

  def job_params
    params.require(:job).permit!
  end
end