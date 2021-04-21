require './make_request.rb'
require './monthly_calender.rb'
require './merge_cal.rb'

class RubyCalFactory
  def get_result
    make_result
  end

  private
  def make_result
    request = make_request
    result = get_cal(request)
  end

  def make_request
    MakeRequest.new.make_request
  end

  def get_cal(request)
    calender = MonthlyCalender.new(request)
    calender.get_cal
  end
end