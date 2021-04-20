require './make_request.rb'
require './monthly_calender.rb'
require './merge_cal.rb'

class RubyCalFactory
  def result
    make_result
  end

  private
  def make_result
    this_request = make_request
    result = get_cal(this_request)
  end

  def make_request
    MakeRequest.new.make_this_request
  end

  def get_cal(this_request)
    this_calender = MonthlyCalender.new(this_request)
    this_calender.get_cal
  end
end