class Task < ActiveRecord::Base
  belongs_to :commitment
  attr_accessor :add_task
  
  validates :due_date, :uniqueness => {:scope => :commitment_id}

  scope :complete, where(['succeeded = ? AND due_date <= ?', true, Date.today])
  scope :failed, where(['succeeded = ? AND due_date <= ?', false, Date.today])
  scope :todo, where(['due_date > ?', Date.today])

  def todo?
    due_date > Date.today
  end
  
  def pending?
    due_date < Date.today && due_date > commitment.delay_period.to_i.days.ago
  end
  
  def failed?
    !pending? && succeeded != false && past?
  end
  
  def past?
    due_date < Date.today
  end
  
end
