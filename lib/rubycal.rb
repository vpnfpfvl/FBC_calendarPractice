require './rubycal_factory.rb'

class RubyCal

  def do_rubycal
    this_order = RubyCalFactory.new
    puts this_order.result
  end

end

rubycal = RubyCal.new
rubycal.do_rubycal