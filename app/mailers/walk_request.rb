class WalkRequest < ApplicationMailer
  default :from => 'no-reply@pupshare.com'

  def send_request_email(user, job)
    @user = user
    @job  = job
    # mail to the pup's owner
    mail( to: @job.user.email, 
      subject: "Please approve or decline #{@user.email}'s request to walk #{@job.pup_name} at #{@job.drop_off_time.to_formatted_s(:long_ordinal)}" )
end  

def send_walker_request_confirmation(user, job)
  @user = user
  @job  = job
  # mail to the walk requester
  mail( to: user.email, 
    subject: "Confirmation of your requested to walk #{@job.user.email}'s pup #{@job.pup_name} at #{@job.drop_off_time.to_formatted_s(:long_ordinal)}" )    
end

def walk_request_confirmation(user, job)
  @user = user
  @job  = job
  # mail to the walk requester
  mail( to: user.email, 
    subject: "Yay! Your request to walk to walk #{@job.user.email}'s pup #{@job.pup_name} at #{@job.drop_off_time.to_formatted_s(:long_ordinal)} was approved!" )
end

def walk_request_denied(user, job)
  @user = user
  @job  = job
  # mail to the walk requester
  mail( to: user.email, 
    subject: "Sorry. Your request to walk to walk #{@job.user.email}'s pup #{@job.pup_name} at #{@job.drop_off_time.to_formatted_s(:long_ordinal)} was denied." )
end

# def cancel_walk_request(job)
#   @job  = job
#   # mail to the walk requester
#   mail( to: user.email, @job.
#     subject: "Sorry. Your request to walk to walk #{@job.user.email}'s pup #{@job.pup_name} at #{@job.drop_off_time.to_formatted_s(:long_ordinal)} was denied." )
# end

# def cancel_confirmed_walk(job)

# end


end
