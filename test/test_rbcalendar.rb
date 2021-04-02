require 'minitest/autorun'
require '../lib/generate_cal.rb'
require '../lib/rb_rendering_cal_opt.rb'
require '../lib/rb_rendering_cal.rb'

class TestRubyCalendar < Minitest::Test
  def test_basic_rendering
    rb_rendering_cal = RbRenderingCal.new
    rb_rendering_cal.basic_rendering
  end

  def test_with_front_and_back_month
    rb_rendering_3monthcal = RbRenderingCal.new
    rb_rendering_3monthcal.with_front_and_back_month
  end
end