# require './argument_vector.rb'
# require 'date'

# class ArgvParse
#   attr_accessor :request_result
#   attr_accessor :parse_result

#   THIS_Y = Date.today.year
#   THIS_M = Date.today.mon
#   THIS_D = Date.today.day
#   THIS_W = Date.today.wday

#   def parse_result_initialize
#     @parse_result = { 
#       basic_month: THIS_M,
#       basic_year: THIS_Y,
#       basic_day: THIS_D,
#       pre_month: nil,
#       pre_year: nil,
#       next_month: nil,
#       next_year: nil,
#       julius: false,
#       highligth: true,
#     }
#   end

#   def parse
#     parse_result_initialize
#     @parse_result.each_key do |key|
#       parse_result[key] = argument_vector.key
#     end

#     return parse_result
#   end

#   def request
#     request_result = parse_result
#     request_result
#   end

# end