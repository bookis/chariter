class TasksController < ApplicationController
  respond_to :html, :json
  def new
    @slug = "tasks"
    @commitment = Commitment.last
    @calendar   = Calendar.new params[:date], current_user.tasks, 'due_date'
  end
  
  def create 
    @task = Task.create(params[:task])
    respond_with @task
  end
end