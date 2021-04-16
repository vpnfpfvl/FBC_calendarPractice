require './make_request.rb'
require './monthly_calender.rb'
require './merge_cal.rb'

class RubyCalFactory
  def make_result
    this_request = make_request
    result = get_cal(this_request)
  end

  def get_cal(this_request)
    this_calender = MonthlyCalender.new(this_request)
    this_calender.get_cal
  end

  def make_request
    MakeRequest.new.make_this_request
  end

  def generate_cal(this_request)
    case this_request[:julius]
    when false
      this_generate = GenerateGregorioCal.new(this_request)
    when true
      this_generate = GenerateJuliusCal.new(this_request)
    end
    this_generate.generate
  end

  def result
    return make_result
  end
end