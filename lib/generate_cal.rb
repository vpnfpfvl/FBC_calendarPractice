require 'date'
require 'color_echo'

class GenerateCal
  THIS_Y = Date.today.year
  THIS_M = Date.today.mon
  THIS_D = Date.today.day
  THIS_W = Date.today.wday

  def initialize(this_request)
    @request = this_request
  end

  class << self
    def generate_days(year, month, day)
      month_first_w = Date.new(year, month, 1).wday
      month_last_d = Date.new(year, month, -1).day

      days_array = Array.new
      optimized_days_array = Array.new 
      month_first_w.times {days_array.push("\s\s")}
      days_array << [*1..month_last_d]
      days_array.flatten!

      p "#{year}年#{month}月"

      days_array.each.with_index do |day, index|
        @day = day

        if @day == "\s\s"
          optimized_days_array << "#{@day}\s"
        elsif @day.to_s.length == 1
          if year == THIS_Y && month == THIS_M && @day == THIS_D
            optimized_days_array << "\e[47m\e[30m\s#{@day}\e[0m\s"
            next
          end
          optimized_days_array << "\s#{@day}\s"
        else
          if year == THIS_Y && month == THIS_M && @day == THIS_D
            optimized_days_array << "\e\e[47m[30m#{@day}\e[0m\s"
            next
          end
          optimized_days_array << "#{@day}\s"
        end
      end
      p result = [month, year, optimized_days_array]
      return result
    end

    def premonth_calc(basic_month, basic_year, pre_num)
      if pre_num == nil then
        p "premonthは要求されていません"
        return
      end
      p "premonthcalc実行"
      pre_month = nil
      pre_year = nil
      premonth_request_result = []

      if basic_month - pre_num > 0
        p pre_month = basic_month - pre_num
        p pre_year = basic_year
      elsif basic_month - pre_num <= 0
        p pre_month = 12 - ((basic_month - pre_num).abs % 12)
        p pre_year =  basic_year - ((basic_month - pre_num).abs / 12) - 1
      else

      end

      count_pre_month = pre_month
      count_pre_year = pre_year

      while count_pre_year < basic_year do
        while count_pre_month <= 12 do
          premonth_request_result << [count_pre_month, count_pre_year]
          count_pre_month += 1
        end
        count_pre_month = 1
        count_pre_year += 1
      end
      while count_pre_month < basic_month
        premonth_request_result << [count_pre_month, count_pre_year]
        count_pre_month += 1
      end
      p premonth_request_result
      return premonth_request_result 
    end

    def nextmonth_calc(basic_month, basic_year, next_num)
      if next_num == nil then
        p "nextmonthは要求されていません"
        return
      end
      p "nextmonthcalc実行"
      next_month = nil
      next_year = nil
      nextmonth_request_result = []

      if basic_month + next_num <= 12
        p next_month = basic_month + next_num
        p next_year = basic_year
      elsif basic_month + next_num > 12
        p next_month = (basic_month + next_num) % 12
        p next_year =  basic_year + (basic_month + next_num) / 12
      else

      end

      count_next_month = basic_month + 1
      count_next_year = basic_year

      while  count_next_year < next_year do
        while count_next_month <= 12 do
          nextmonth_request_result << [count_next_month, count_next_year]
          count_next_month += 1
        end
        count_next_month = 1
        count_next_year += 1
      end
      while count_next_month <= next_month
        nextmonth_request_result << [count_next_month, count_next_year]
        count_next_month += 1
      end
      p nextmonth_request_result
      return nextmonth_request_result 
  
    end

    def rendering_g_cal(all_date_array)
      @all_date_array = all_date_array
      p @all_date_array.size

      while @all_date_array.size / 3 >= 1 do
        @all_date_array[0]
      end


    end

    def generate_three_months_g_cal(first_month, second_month, third_month)
      @first_month_day_cells = first_month[2]
      @second_month_day_cells = second_month[2]
      @third_month_day_cells = third_month[2]

      maxsize = [@first_month_day_cells.size, @second_month_day_cells.size, @third_month_day_cells.size].max

      if (28 <  maxsize && maxsize < 36) then
        column = 5
      else
        column = 6
      end

      while @first_month_day_cells.size < column * 7 do
        @first_month_day_cells << "   "
      end
      while @second_month_day_cells.size < column * 7 do
        @second_month_day_cells << "   "
      end
      while @third_month_day_cells.size < column * 7 do
        @third_month_day_cells << "   "
      end

      three_months_day_cells = Array.new(column).map{Array.new(21,nil)}
      three_months_day_cells.map.each_with_index do |element, index|
        element[0..6] = @first_month_day_cells[index * 7..index * 7 + 6]
        element[7..13] = @second_month_day_cells[index * 7..index * 7 + 6]
        element[14..20] = @third_month_day_cells[index * 7..index * 7 + 6]

        element.insert(14, " ")
        element.insert(7, " ")
        end

        if column == 6
          three_months_days_string_result = <<-"EOS"
#{three_months_day_cells[0].join}
#{three_months_day_cells[1].join}
#{three_months_day_cells[2].join}
#{three_months_day_cells[3].join}
#{three_months_day_cells[4].join}
#{three_months_day_cells[5].join}
          EOS
        else
          three_months_days_string_result = <<-"EOS"
#{three_months_day_cells[0].join}
#{three_months_day_cells[1].join}
#{three_months_day_cells[2].join}
#{three_months_day_cells[3].join}
#{three_months_day_cells[4].join}
          EOS

        end    

        three_months_days_string_result = <<-"EOS"
      #{first_month[0]}月 #{first_month[1]}               #{second_month[0]}月 #{second_month[1]}              #{third_month[0]}月 #{third_month[1]}
日 月 火 水 木 金 土  日 月 火 水 木 金 土  日 月 火 水 木 金 土
#{three_months_days_string_result}
          EOS
      
      return three_months_days_string_result
    end

    def generate_two_months_g_cal(first_month, second_month)
      @first_month_day_cells = first_month[2]
      @second_month_day_cells = second_month[2]

      maxsize = [@first_month_day_cells.size, @second_month_day_cells.size].max

      if (28 <  maxsize && maxsize < 36) then
        column = 5
      else
        column = 6
      end

      while @first_month_day_cells.size < column * 7 do
        @first_month_day_cells << "   "
      end
      while @second_month_day_cells.size < column * 7 do
        @second_month_day_cells << "   "
      end

      two_months_day_cells = Array.new(column).map{Array.new(14,nil)}
      two_months_day_cells.map.each_with_index do |element, index|
        element[0..6] = @first_month_day_cells[index * 7..index * 7 + 6]
        element[7..13] = @second_month_day_cells[index * 7..index * 7 + 6]

        element.insert(7, " ")
      end

      if column == 6
        two_months_days_string_result = <<-"EOS"
#{two_months_day_cells[0].join}
#{two_months_day_cells[1].join}
#{two_months_day_cells[2].join}
#{two_months_day_cells[3].join}
#{two_months_day_cells[4].join}
#{two_months_day_cells[5].join}
      EOS
      else
        two_months_days_string_result = <<-"EOS"
#{two_months_day_cells[0].join}
#{two_months_day_cells[1].join}
#{two_months_day_cells[2].join}
#{two_months_day_cells[3].join}
#{two_months_day_cells[4].join}
      EOS
      end

      two_months_days_string_result = <<-"EOS"
      #{first_month[0]}月 #{first_month[1]}               #{second_month[0]}月 #{second_month[1]}
日 月 火 水 木 金 土  日 月 火 水 木 金 土
#{two_months_days_string_result}
        EOS
      
      return two_months_days_string_result
    end

        
    def generate_one_month_g_cal(first_month)
      @first_month_day_cells = first_month[2]

      maxsize = [@first_month_day_cells.size].max

      if (28 <  maxsize && maxsize < 36) then
        column = 5
      else
        column = 6
      end

      while @first_month_day_cells.size < column * 7 do
        @first_month_day_cells << "   "
      end

      one_month_day_cells = Array.new(column).map{Array.new(14,nil)}
      one_month_day_cells.map.each_with_index do |element, index|
        element[0..6] = @first_month_day_cells[index * 7..index * 7 + 6]
      end

      if column == 6
        one_month_days_string_result = <<-"EOS"
#{one_month_day_cells[0].join}
#{one_month_day_cells[1].join}
#{one_month_day_cells[2].join}
#{one_month_day_cells[3].join}
#{one_month_day_cells[4].join}
#{one_month_day_cells[5].join}
            EOS
      else
        one_month_days_string_result = <<-"EOS"
#{one_month_day_cells[0].join}
#{one_month_day_cells[1].join}
#{one_month_day_cells[2].join}
#{one_month_day_cells[3].join}
#{one_month_day_cells[4].join}
            EOS
      end
 

      one_month_days_string_result = <<-"EOS"
      #{first_month[0]}月 #{first_month[1]}
日 月 火 水 木 金 土
#{one_month_days_string_result}
      EOS
      
      return one_month_days_string_result
    end
  end

  def generate
    puts "カレンダーを生成します"
    result = ""
    all_request_date = []
    premonth_request = self.class.premonth_calc(@request[:basic_month], @request[:basic_year], @request[:pre_month])
    nextmonth_request = self.class.nextmonth_calc(@request[:basic_month], @request[:basic_year], @request[:next_month])

    if premonth_request != nil
      all_request_date += premonth_request
    end
    all_request_date += [[@request[:basic_month], @request[:basic_year]]]
    if nextmonth_request != nil
      all_request_date += nextmonth_request
    end
    p "-----------------"
    p all_request_date
    all_date_array = all_request_date.map do |date|
      self.class.generate_days(date[1], date[0], THIS_D)
    end

    all_date_array_for_resource = all_date_array
    puts "要求された月は#{all_date_array.size}つです"

    while all_date_array_for_resource.size / 3 >= 1 do
       result += self.class.generate_three_months_g_cal(all_date_array_for_resource[0], all_date_array_for_resource[1], all_date_array_for_resource[2])
      all_date_array_for_resource.slice!(0, 3)
    end

    if all_date_array_for_resource.size == 2
      result += self.class.generate_two_months_g_cal(all_date_array_for_resource[0], all_date_array_for_resource[1])
      all_date_array_for_resource.slice!(0, 2)
    end

    if all_date_array_for_resource.size == 1
      result += self.class.generate_one_month_g_cal(all_date_array_for_resource[0])
      all_date_array_for_resource.slice!(0, 1)
    end
    return result

  end
  
end
