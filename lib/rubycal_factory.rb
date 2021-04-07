require './make_request.rb'
require './generate_cal.rb'

class RubyCalFactory

  def make_result
    this_request = make_request
    # @result = "dummy"
    result = generate_cal(this_request)
  end

  def make_request
    MakeRequest.new.make_this_request
  end

  def generate_cal(this_request)
    this_generate = GenerateCal.new(this_request)
    this_generate.generate
  end

  def result
    return make_result
  end

end