require "spec_helper"

describe Calendar do
  let(:cal) { Calendar.new("June 2011") }
  let(:skel) { cal.initialize_weeks }
  it "should have a big crazy hash" do
    skel.should eq weeks_skeleton
  end
  
  it "should have a consistent date" do
    cal[4][:date].should eq "2011-06-01"
    cal[36][:date].should eq "2011-07-03"
  end
  
  it "should be able to find by date" do
    cal.find("2011-06-01").should eq cal[4]
  end
  
  it "should have a past, present, future tag" do
    cal = Calendar.new
    cal[1][:classes].should include "past"
    cal.find(Date.today)[:classes].should include 'today'
    cal[42][:classes].should include "future"
  end
  
  it "should take any array of objects and date" do
    hash = {:key => "Value", :date => Date.parse("June 1 2011")}
    cal.add_objects([hash], :date)
    cal.find('2011-06-01')[:objects].should include hash
  end
  
  it "should accept a task object" do
    task = Task.create
    task.update_attribute(:created_at, Time.parse("June 1 2011 12pm"))
    cal.add_objects(Task.all, 'created_at')
    cal.find('2011-06-01')[:objects].should include task
  end
  
  it "shouldn't blow up if an object isn't in the calendar" do
    task = Task.create
    lambda { cal.add_objects(Task.all, 'created_at') }.should_not raise_error
  end
end