require './make_request.rb'
require './generate_julius_cal.rb'
require './generate_gregorio_cal.rb'

class RubyCalFactory

  def make_result
    this_request = make_request
    result = generate_cal(this_request)
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