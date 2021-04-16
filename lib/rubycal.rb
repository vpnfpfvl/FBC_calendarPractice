require './rubycal_factory.rb'

def do_rubycal
  this_order = RubyCalFactory.new
  puts this_order.result
end

do_rubycal