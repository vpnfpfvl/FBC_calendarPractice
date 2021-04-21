require './rubycal_factory.rb'

def do_rubycal
  order = RubyCalFactory.new
  puts order.get_result
end

do_rubycal