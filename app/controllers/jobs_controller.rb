class JobsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_job, only: [:show, :edit, :update, :destroy]

  # GET /jobs
  # GET /jobs.json
  def index
    @jobs = Job.all
  end

  # GET /jobs/1
  # GET /jobs/1.json
  def show
  end

  # GET /jobs/new
  def new
    @job = Job.new
  end

  # GET /jobs/1/edit
  def edit
  end

  # POST /jobs
  # POST /jobs.json
  def create
    # associate authenticated user with a job
    @job = current_user.jobs.new(job_params)

    respond_to do |format|
      if @job.save
        format.html { redirect_to @job, notice: 'Job was successfully created.' }
        format.json { render :show, status: :created, location: @job }
      else
        format.html { render :new }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /jobs/1
  # PATCH/PUT /jobs/1.json
  def update
    respond_to do |format|
      if @job.update(job_params)
        if params[:walk_request]
          if current_user.user_pending_requests_count == 0 # user can only have one walk request outstanding for now
            WalkRequest.send_request_email.deliver_now
            current_user.user_pending_requests_count += 1
            current_user.save
            redirect_to root_path, notice: 'Request email sent to pup owner.'
            return
          else
            redirect_to root_path, alert: 'You already have a request pending. Max allowed is 1.'
            return
          end
          if params[:request_approved]
            WalkRequest.walk_request_confirmation.deliver_now
            job.walk_request_pending = false
            job.walk_request_pending_user_id = nil
            job.walk_request_confirmed = true
            job.walker_id = current_user.id
            # IDEA: convert view to two columns 1) "need a walk" 2) "walk scheduled"
            # IDEA (continued) once confirmed, move job into "walk scheduled" column
            return
          else
            WalkRequest.walk_request_denied.deliver_now
            job.walk_request_pending = false
            job.walk_request_pending_user_id = nil
            job.walk_request_confirmed = false
            job.walker_id = nil
            return
          end
        else
          format.html { redirect_to @job, notice: 'Job was successfully updated.' }
          format.json { render :show, status: :ok, location: @job }
        end
      else
        format.html { render :edit }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /jobs/1
  # DELETE /jobs/1.json
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
