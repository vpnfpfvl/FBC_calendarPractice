rb_rendering_cal_opt = OptionParser.new
rb_rendering_cal_opt.on('-3') {rb_rendering_cal.with_front_and_back_month}
rb_rendering_cal_opt.on('-A') {| am_num | rb_rendering_cal.with_after_month(am_num)}
rb_rendering_cal_opt.on('-B') {| bm_num | rb_rendering_cal.with_before_month(bm_num)}
rb_rendering_cal_opt.on('-h') {rb_rendering_cal.highlight_turnoff}
rb_rendering_cal_opt.on('-j') {rb_rendering_cal.julian}
rb_rendering_cal_opt.on('-y') {| sy_num | rb_rendering_cal.select_year}
rb_rendering_cal_opt.on('-m') {| sm_num | rb_rendering_cal.select_month}