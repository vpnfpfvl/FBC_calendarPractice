require 'minitest/autorun'
require '../lib/generate_cal.rb'
require '../lib/rb_cal_request.rb'
require '../lib/rb_rendering_cal.rb'

class TestRubyCalendar < Minitest::Test
  def test_basic_rendering
    rb_rendering_cal = RbRenderingCal.new
    rb_rendering_cal.basic_rendering
  end

  # def test_opt_run

  # end
end