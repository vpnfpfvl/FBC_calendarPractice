# frozen_string_literal: true

require './option'
require './merge_cal'

class RubyCalFactory
  def generate
    make_cal(request)
  end

  def request
    option = Option.new
    option.get_request
  end

  def make_cal(request)
    merge_cal = MergeCal.new(request)
    merge_cal.merge
  end
end
