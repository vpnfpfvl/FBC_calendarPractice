require 'optparse'

class RbRenderingCal
  rb_rendering_cal_opt = RbRenderingCal.new

  def basic_rendering
    generate_cal = GenerateCal.new
    generate_cal.this_month
  end

  def with_front_and_back_month
    generate_3month_cal = GenerateCal.new
    generate_3month_cal.three_month
  end

  def with_after_month(am_num)
  end

  def with_before_month(bm_num)
  end

  def highlight_turnoff
  end

  def julian
  end

  def select_year(sy_num)
  end

  def select_month(sm_num)
  end

end



