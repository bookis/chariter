class CommitmentsController < ApplicationController
  def index
    @commitments = current_user.commitments.all
    @calendar   = Calendar.new params[:date], current_user.tasks, 'due_date'
  end

  def show
    @slug = "commitments"
    @commitment = Commitment.find(params[:id])
    @calendar   = Calendar.new params[:date], @commitment.tasks, 'due_date'
  end

  def new
    @commitment = Commitment.new(params[:commitment])
  end
  
  def create
    @commitment = current_user.commitments.new(params[:commitment])
    if @commitment.save!
      redirect_to commitments_path
    else
      render :new
    end
  end

  def edit
    @commitment = Commitment.find(params[:id])
  end
  
  def update
    @commitment = Commitment.find(params[:id])
    params[:commitment][:tasks_attributes].delete_if { |k,v| v.has_value?('false')}
    @commitment.update_attributes(params[:commitment])
    redirect_to @commitment
  end
  
  def destroy
    @commitment = Commitment.find(params[:id])
    @commitment.destroy
    redirect_to commitments_path
  end
  
end
