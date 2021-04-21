require 'date'
require 'color_echo'
require './calender_date_unit.rb'

class MonthlyCalender
  THIS_Y = Date.today.year
  THIS_M = Date.today.mon
  THIS_D = Date.today.day
  THIS_W = Date.today.wday

  def initialize(request)
    @request = request
  end

  def get_cal
    result = ""
    all_request_about_month = make_request_about_month
    layout_status = make_layout_status
    all_date_array = all_request_about_month.map do |date|
      this_date = CalenderDateUnit.new(date[0], date[1], @request)
      this_date.generate_days
    end
    merge_result = merge_cal(all_date_array, layout_status)
  end

  private
  def make_request_about_month
    all_request_about_month_result = []
    premonth_request = premonth_calc(@request[:basic_month], @request[:basic_year], @request[:pre_month])
    nextmonth_request = nextmonth_calc(@request[:basic_month], @request[:basic_year], @request[:next_month])

    if premonth_request != nil
      all_request_about_month_result += premonth_request
    end
    all_request_about_month_result += [[@request[:basic_month], @request[:basic_year]]]
    if nextmonth_request != nil
      all_request_about_month_result += nextmonth_request
    end
    all_request_about_month_result
  end

  def premonth_calc(basic_month, basic_year, pre_num)
    if pre_num.nil?
      return
    end

    pre_month = nil
    pre_year = nil
    premonth_request_result = []
    case
    when basic_month - pre_num > 0
      count_pre_month = basic_month - pre_num
      count_pre_year = basic_year
    when basic_month - pre_num <= 0
      count_pre_month = 12 - ((basic_month - pre_num).abs % 12)
      count_pre_year =  basic_year - ((basic_month - pre_num).abs / 12) - 1
    end

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
    premonth_request_result 
  end

  def nextmonth_calc(basic_month, basic_year, next_num)
    if next_num.nil?
      return
    end
    next_month = nil
    next_year = nil
    nextmonth_request_result = []
    case
    when basic_month + next_num <= 12
      next_month = basic_month + next_num
      next_year = basic_year
    when basic_month + next_num > 12
      next_month = (basic_month + next_num) % 12
      next_year =  basic_year + (basic_month + next_num) / 12
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
    nextmonth_request_result 
  end

  def make_layout_status
    layout_status_result = {}    
    case @request[:julius]
    when true
      layout_status_result[:margin] = "\s\s\s"
      layout_status_result[:blank] = "\s\s\s"
      layout_status_result[:blank_for_one_char] = "\s\s"
      layout_status_result[:blank_for_two_char]= "\s"
      layout_status_result[:blank_for_three_char]= ""
      layout_status_result[:month_row_num] = 2
      layout_status_result[:one_week] =  " 日  月  火  水  木  金  土"
      layout_status_result[:two_weeks] =  " 日  月  火  水  木  金  土   日  月  火  水  木  金  土"
      layout_status_result[:three_weeks] =  " 日  月  火  水  木  金  土   日  月  火  水  木  金  土   日  月  火  水  木  金  土" 
      one_caption = Proc.new{ |first_month, first_year| "          #{first_month}月 #{first_year}"}
      two_caption = Proc.new{ |first_month, first_year, second_month, second_year| "          #{first_month}月 #{first_year}                     #{second_month}月 #{second_year}" }
      three_caption = Proc.new{ |first_month, first_year, second_month, second_year, third_month, third_year| "          #{first_month}月 #{first_year}                 #{second_month}月 #{second_year}                 #{third_month}月 #{third_year}" }
      layout_status_result[:one_caption] = one_caption
      layout_status_result[:two_caption] = two_caption
      layout_status_result[:three_caption] = three_caption
    when false
      layout_status_result[:margin] = "\s\s"
      layout_status_result[:blank] = "\s\s"
      layout_status_result[:blank_for_one_char] = "\s"
      layout_status_result[:blank_for_two_char] = ""
      layout_status_result[:month_row_num] = 3
      layout_status_result[:one_week] =  "日 月 火 水 木 金 土"
      layout_status_result[:two_weeks] =  "日 月 火 水 木 金 土  日 月 火 水 木 金 土"
      layout_status_result[:three_weeks] =  "日 月 火 水 木 金 土  日 月 火 水 木 金 土  日 月 火 水 木 金 土"
      one_caption = Proc.new{ |first_month, first_year| "       #{first_month}月 #{first_year}"}
      two_caption = Proc.new{ |first_month, first_year, second_month, second_year| "       #{first_month}月 #{first_year}              #{second_month}月 #{second_year}" }
      three_caption = Proc.new{ |first_month, first_year, second_month, second_year, third_month, third_year| "       #{first_month}月 #{first_year}              #{second_month}月 #{second_year}              #{third_month}月 #{third_year}" }
      layout_status_result[:one_caption] = one_caption
      layout_status_result[:two_caption] = two_caption
      layout_status_result[:three_caption] = three_caption
    end

    case @request[:year_position]
    when "default"
      header_position = Proc.new{ |this_year| "" }
      layout_status_result[:header_position] = header_position

    when "header"
      case @request[:julius]
      when true
        one_caption = Proc.new{ |first_month, first_year| "             #{first_month}月"}
        two_caption = Proc.new{ |first_month, first_year, second_month, second_year| "             #{first_month}月                          #{second_month}月 " }
        header_position = Proc.new{ |this_year| "                          #{this_year}年\n" }
        layout_status_result[:one_caption] = one_caption
        layout_status_result[:two_caption] = two_caption
        layout_status_result[:header_position] = header_position
      when false
        one_caption = Proc.new{ |first_month, first_year| "       #{first_month}月"}
        two_caption = Proc.new{ |first_month, first_year, second_month, second_year| "       #{first_month}月              #{second_month}月" }
        three_caption = Proc.new{ |first_month, first_year, second_month, second_year, third_month, third_year| "         #{first_month}月                  #{second_month}月                  #{third_month}月" }
        header_position = Proc.new{ |this_year| "                            #{this_year}年\n" }
        layout_status_result[:one_caption] = one_caption
        layout_status_result[:two_caption] = two_caption
        layout_status_result[:three_caption] = three_caption
        layout_status_result[:header_position] = header_position
      end
    end

    case @request[:highligth]
    when true
      layout_status_result[:highligth] = true
    when false
      layout_status_result[:highligth] = false
    end
    layout_status_result
  end

  def merge_cal(all_date_array, layout_status)
    this_calender = MergeCalender.new(all_date_array, layout_status)
    this_calender.merge
  end
end











