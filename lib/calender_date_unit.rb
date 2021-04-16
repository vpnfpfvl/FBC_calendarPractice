class CalenderDateUnit
  THIS_Y = Date.today.year
  THIS_M = Date.today.mon
  THIS_D = Date.today.day
  THIS_W = Date.today.wday

  def initialize(year, month, day, request)
    @year = year
    @month = month
    @day = day
    @request = request
  end


  def generate_days
    month_first_w = Date.new(@year, @month, 1).wday
    month_last_d = Date.new(@year, @month, -1).day

    days_array = Array.new
    optimized_days_array = Array.new 
    month_first_w.times {days_array.push("blank")}
    case @request[:julius]
    when true
      j_month_first_d = Date.new(@year, @month,1).yday
      j_month_last_d = Date.new(@year, @month,month_last_d).yday  
      days_array << [*j_month_first_d..j_month_last_d]
    when false
      days_array << [*1..month_last_d]
    end
    # days_array << [*1..month_last_d]
    days_array.flatten!

    p "#{@year}年#{@month}月"

    days_array.each.with_index do |day, index|
      @day = day

      if @day == "blank"
        optimized_days_array << "#{@day}\s"
      elsif @day.to_s.length == 1
        if @year == THIS_Y && @month == THIS_M && @day == THIS_D && @request[:highligth] == true
          optimized_days_array << "\e[47m\e[30mblank_for_one_char#{@day}\e[0m\s"
          next
        end
        optimized_days_array << "blank_for_one_char#{@day}\s"
      elsif @day.to_s.length == 2
        if @year == THIS_Y && @month == THIS_M && @day == THIS_D && @request[:highligth] == true
          optimized_days_array << "\e\e[47m\e[30mblank_for_two_char#{@day}\e[0m\s"
          next
        end
        optimized_days_array << "blank_for_two_char#{@day}\s"
      elsif @day.to_s.length == 3
        if @year == THIS_Y && @month == THIS_M && @day == THIS_D && @request[:highligth] == true
          optimized_days_array << "\e\e[47m\e[30mblank_for_three_char#{@day}\e[0m\s"
          next
        end
        optimized_days_array << "blank_for_three_char#{@day}\s"
      else

      end
    end
    result = [@month, @year, optimized_days_array]
  end
end