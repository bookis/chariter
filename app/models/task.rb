class Task < ActiveRecord::Base
  belongs_to :commitment
  attr_accessor :add_task
  
  validates :due_date, :uniqueness => {:scope => :commitment_id}
  
end
