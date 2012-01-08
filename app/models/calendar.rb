class Calendar
  
  def initialize(date=Date.today, objects=[], objects_key = nil)
    @weeks = initialize_weeks
    @date  = to_date(date) || Date.today
    fill_days!(@date)
    add_objects(objects, objects_key)
  end
  
  def find(date)
    found = @weeks.select{ |k,v| v[:date] == simple_date(date)}
    found.first[1] unless found.blank?
  end
  
  def date
    @date
  end
  
  def next_month
    @date.next_month
  end

  def prev_month
    @date.prev_month
  end
  
  def [](val)
    @weeks[val]
  end
  
  def each(&block)
    @weeks.each &block
  end
  
  def add_objects(objects, date_key)
    objects.each do |object|
      date = date_key.instance_of?(Symbol) ? object[date_key] : object.send(date_key)
      day = find(date)
      next if day.nil?
      day[:objects].blank? ? day[:objects] = [object] : day[:objects] << object
      if object.instance_of? Task
        day[:classes] << "pending" if object.pending?
        day[:classes] << "failed" if object.failed?
        day[:classes] << "succeeded" if object.succeeded?
      end
    end
  end
  
  def initialize_weeks
    months = {}
    count = 1
    6.times do 
      %w(sunday monday tuesday wednesday thursday friday saturday).each { |day| months[count] = {:day => day}; count += 1}
    end
    months
  end
  
  def fill_days!(date)
    days = date_range(date)
    days.each_with_index do |day, i|
      @weeks[i + 1][:date]         = day.to_s(:db)
      @weeks[i + 1][:day_of_month] = day.day
      @weeks[i + 1][:objects]      = []
      add_classes(day, i)
    end
  end
  
  private
  
  def date_range(date)
    first_day = date.beginning_of_month
    last_day  = date.end_of_month
    first_day -= first_day.wday.days
    days = (first_day..last_day).to_a
    until days.size >= 42
      days << days.last + 1.day
    end
    days
  end
  
  def add_classes(day, i)
    month      = day.month
    day        = day.yday
    today      = Date.today.yday
    this_month = Date.today.month
    
    classes  = ['date']
    classes << "past" if day < today
    classes << "today" if day == today
    classes << "future" if day > today

    classes << "prev_month" if month < this_month
    classes << "next_month" if month > this_month
    
    @weeks[i + 1][:classes] = classes
  end
  
  def to_date(date)
    if date.nil?
      Date.today
    elsif date.instance_of? String
      Date.parse(date)
    else
      date.to_date
    end
  end
  
  def simple_date(date)
    to_date(date).to_s(:db)
  end
    
end