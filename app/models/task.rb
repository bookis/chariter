class AddableValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    p value
    if value.to_s != 'true'
      record.errors[:base] << "task must be confirmed"
    end
  end
end

class Task < ActiveRecord::Base
  belongs_to :commitment
  attr_accessor :add_task
  
  validates :due_date, :uniqueness => {:scope => :commitment_id}
  # validates :add_task, :addable => true 
  
end
