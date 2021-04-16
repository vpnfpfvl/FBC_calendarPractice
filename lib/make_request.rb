require './optparse_run.rb' # いらなくなる
require './argument_vector.rb'
require 'date'

class MakeRequest
  THIS_Y = Date.today.year
  THIS_M = Date.today.mon
  THIS_D = Date.today.day
  THIS_W = Date.today.wday

  def initialize
    @argument_vector = ArgumentVector.new
    @generate_request_result = {}
    @default_request_status = {
      basic_month: THIS_M,
      basic_year: THIS_Y,
      basic_day: THIS_D,
      pre_month: nil,
      pre_year: nil,
      next_month: nil,
      next_year: nil,
      julius: false,
      highligth: true,
      year_position: "default"
    }
  end

  def make_this_request
    this_request = generate_request
    return this_request
  end

  def generate_request
    @request_keys = @default_request_status
    @generate_request_result = @argument_vector.get_request_status(@request_keys)
  end

  def get_status(key)
    k = key.to_s
    @argument_vector.choose_get(k)
  end

end