# frozen_string_literal: true

class CalendarDateUnit
  THIS_Y = Date.today.year
  THIS_M = Date.today.mon
  THIS_D = Date.today.day
  THIS_W = Date.today.wday

  def initialize(month, year, request)
    @year = year
    @month = month
    @request = request
  end

  def generate_days
    [@month, @year, days]
  end

  private

  def days
    add_blank(generate_one_month_days)
  end

  def generate_one_month_days
    case @request[:julius]
    when true
      (j_month_first_d..j_month_last_d).to_a.flatten
    when false
      (1..month_last_d).to_a.flatten
    end
  end

  def month_last_d
    Date.new(@year, @month, -1).day
  end

  def j_month_first_d
    Date.new(@year, @month, 1).yday
  end

  def j_month_last_d
    Date.new(@year, @month, month_last_d).yday
  end

  def month_first_w
    Date.new(@year, @month, 1).wday
  end


  def add_blank(days_array)
    month_first_w.times { days_array.unshift('blank') }
    days_array.each do |day|
      if day.to_s.include?('blank')
        result << "#{@request[:mergin]}#{@request[:blank]}"
      elsif today?(day)
        result << "\e[47m\e[30mblank_for_#{day.to_s.length}char#{day}\e[0m\s"
      else
        result << "blank_for_#{day.to_s.length}char#{day}\s"
      end
    end
    result
  end

  def today?(day)
  case @request[:julius]
    when true
      @year == THIS_Y && @month == THIS_M && day == Date.new(@year, @month, THIS_D).yday && @request[:highligth]
    when false
      @year == THIS_Y && @month == THIS_M && day == THIS_D && @request[:highligth]
    end
  end
end
