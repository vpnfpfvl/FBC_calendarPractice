require 'date'
require 'color_echo'



class GenerateCal
  THIS_Y = Date.today.year
  THIS_M = Date.today.mon
  THIS_D = Date.today.day
  THIS_W = Date.today.wday

  class << self
    def generate_days(year: THIS_Y, month: THIS_M, day: THIS_D)
      month_first_w = Date.new(year, month, 1).wday
      month_last_d = Date.new(year, month, -1).day

      days_array = Array.new
      day_cells_result = Array.new
      month_first_w.times {days_array.push("\s\s")}
      days_array << [*1..month_last_d]
      days_array.flatten!

      days_array.each.with_index do |day, index|
        @day = day
        if @day == "\s\s"
          day_cells_result << "#{@day}\s"
        elsif @day.to_s.length == 1
          day_cells_result << "\s#{@day}\s"
        else
          day_cells_result << "#{@day}\s"
        end
      end
      return day_cells_result
    end

    def generate_1month_days_string(cells)
      @cells = cells
      days_result = ""
      @cells.map.with_index do |cell, i| 
        if (i % 7 == 6 && i != 0)
          cell = "#{cell}\n"
        end
        days_result << cell
      end
      return days_result
    end

    def premonth_calc
      preyear_result = THIS_Y - 1
      premonth_result = THIS_M - 1
      if premonth_result == 0 then
        premonth_result = 12
        return premonth_result, preyear_result
      end
      return premonth_result, THIS_Y
    end

    def postmonth_calc
      postyear_result = THIS_Y + 1
      postmonth_result = THIS_M + 1
      if postmonth_result == 13 then 
        postmonth_result = 1
        return postmonth_result, postyear_result
      end
      return postmonth_result, THIS_Y
  
    end

    def generate_three_month_days_string(premonth_day_cells, thismonth_day_cells, postmonth_day_cells)
      @premonth_day_cells = premonth_day_cells
      @thismonth_day_cells = thismonth_day_cells
      @postmonth_day_cells = postmonth_day_cells

      maxsize = [@premonth_day_cells.size, @thismonth_day_cells.size, @postmonth_day_cells.size].max

      if (28 <  maxsize && maxsize < 36) then
        column = 5
      else
        column = 6
      end

      while @premonth_day_cells.size < column * 7 do
        @premonth_day_cells << "   "
      end
      while @thismonth_day_cells.size < column * 7 do
        @thismonth_day_cells << "   "
      end
      while @postmonth_day_cells.size < column * 7 do
        @postmonth_day_cells << "   "
      end

      three_month_day_cells = Array.new(column).map{Array.new(21,nil)}
      three_month_day_cells.map.each_with_index do |element, index|
        @premonth_day_cells[index * 7..index * 7 + 6]
        element[0..6] = @premonth_day_cells[index * 7..index * 7 + 6]
        element[7..13] = @thismonth_day_cells[index * 7..index * 7 + 6]
        element[14..20] = @postmonth_day_cells[index * 7..index * 7 + 6]

        element.insert(14, " ")
        element.insert(7, " ")
        end

        three_month_days_string_result = <<-"EOS"
#{three_month_day_cells[0].join}
#{three_month_day_cells[1].join}
#{three_month_day_cells[2].join}
#{three_month_day_cells[3].join}
#{three_month_day_cells[4].join}
#{three_month_day_cells[5].join}
      EOS
      return three_month_days_string_result
    end
  end

  def this_month
    month_day_cells = self.class.generate_days
    this_month_days_string = self.class.generate_1month_days_string(month_day_cells)
    puts <<-"EOS"
      #{THIS_M}月 #{THIS_Y}
日 月 火 水 木 金 土
#{this_month_days_string}

    EOS
  end

  def three_month
    premonth, preyear = self.class.premonth_calc
    postmonth, postyear = self.class.postmonth_calc

    premonth_day_cells = self.class.generate_days(year: preyear, month: premonth)
    thismonth_day_cells = self.class.generate_days
    postmonth_day_cells = self.class.generate_days(year: postyear, month: postmonth)
    days = self.class.generate_three_month_days_string(premonth_day_cells, thismonth_day_cells, postmonth_day_cells)

    puts <<-"EOS"
      #{premonth}月 #{postyear}              #{THIS_M}月 #{THIS_Y}              #{postmonth}月 #{postyear}
日 月 火 水 木 金 土  日 月 火 水 木 金 土  日 月 火 水 木 金 土
#{days}

  EOS
  end

end
