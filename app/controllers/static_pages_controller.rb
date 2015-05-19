class StaticPagesController < ApplicationController
  def index
    @job = Job.new
  end

  def help
  end
end
