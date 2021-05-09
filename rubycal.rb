# frozen_string_literal: true
# require './rubycal_factory'

# def display_rubycal
#   ruby_cal_factory = RubyCalFactory.new
#   puts ruby_cal_factory.generate
# end

# do_rubycal

require 'optparse'
require 'date'

def optparse
  # THIS_Y = Date.today.year
  # THIS_M = Date.today.mon
  # THIS_D = Date.today.day
  # THIS_W = Date.today.wday


opt = OptionParser.new
  def argv_parser_on_y(opt)
    opt.on('-y VAL') do |v|
    end
  end
end

argv_parser_on_y