class JobsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_job, only: [:show, :edit, :update, :destroy]

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
    # associate authenticated user with a job
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

  def update
#     binding.pry
    if params[:walk_request] && current_user.user_pending_requests_count == 0 # user can only have one walk request outstanding for now
      WalkRequest.send_request_email(current_user).deliver_now
      current_user.user_pending_requests_count += 1
      current_user.save
      redirect_to root_path, notice: 'Request email sent to pup owner.'
      return
    elsif params[:walk_request] && current_user.user_pending_requests_count != 0
      @job.walk_request_pending = false
      @job.walk_request_pending_user_id = nil  
      @job.save
      redirect_to root_path, alert: 'Max outstanding requests is 1.'
      return
    elsif params[:request_approved]
      WalkRequest.walk_request_confirmation(current_user).deliver_now
      @job.walk_request_pending = false
      @job.walk_request_pending_user_id = nil
      @job.walk_request_confirmed = true
      @job.walker_id = current_user.id
      @job.save
      redirect_to root_path      
      return
    elsif !params[:request_approved].nil? && !params[:request_approved] # messy fix for 'Edit' button mistakenly firing denial email (and not saving object after changes)
      WalkRequest.walk_request_denied(current_user).deliver_now
      @job.walk_request_pending = false
      @job.walk_request_pending_user_id = nil
      @job.walk_request_confirmed = false
      @job.walker_id = nil
      @job.save
      redirect_to root_path
      return
    end
    
    # the usual update action follows
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

  # Never trust parameters from the scary internet, only allow the white list through.
  def job_params
    params.require(:job).permit!
  end
end
