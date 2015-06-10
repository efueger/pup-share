class JobsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :walk_request, :approve_walk_request, :deny_walk_request]
  before_action :set_job, only: [:show, :edit, :update, :destroy, :walk_request, :approve_walk_request, :deny_walk_request]

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
        format.html { redirect_to root_path, notice: 'Job was successfully created.' }
        format.json { render :show, status: :created, location: @job }
      else
        format.html { render :new }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  def walk_request
    @job.walk_request(current_user, @job.id)
    redirect_to root_path, notice: 'Request email sent to pup\'s owner.'
  end

  def approve_walk_request
    # method on the model...?
    # call the mailer from the model
    # the method call is triggered by @job.approve_request
    WalkRequest.walk_request_confirmation(current_user).deliver_now
    @job.update walk_request_pending: false, walk_request_pending_user_id: nil, 
    walk_request_confirmed: true, walker_id: current_user.id
    redirect_to root_path      
  end

  def deny_walk_request
    WalkRequest.walk_request_denied(current_user).deliver_now
    @job.update walk_request_pending: false, walk_request_pending_user_id: nil,
    walk_request_confirmed: false, walker_id: nil
    redirect_to root_path
  end

  def update
    respond_to do |format|
      if @job.update(job_params)
        format.html { redirect_to root_path, notice: 'Job was successfully updated.' }
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
      format.html { redirect_to jobs_url, notice: 'Job was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_job
    @job = Job.find(params[:id])
  end

  def job_params
    params.require(:job).permit!
  end
end