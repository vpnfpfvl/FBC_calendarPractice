class MergeCalender
  THIS_Y = Date.today.year
  THIS_M = Date.today.mon
  THIS_D = Date.today.day
  THIS_W = Date.today.wday

  def initialize(all_date_array, layout_status)
    @all_date_array = all_date_array
    @layout_status = layout_status
  end

  def merge
    rendering_calender(@all_date_array)
  end

  private
  def rendering_calender(all_date_array)
    rendering_string_result = ""
    replaced_all_date_array = Marshal.load(Marshal.dump(all_date_array))
    replaced_all_date_array = replace_layout_var(replaced_all_date_array)
    case @layout_status[:month_row_num]
    when 3
      while replaced_all_date_array.size / 3 >= 1 do
        rendering_string_result += merge_date_unit(3, replaced_all_date_array[0], replaced_all_date_array[1], replaced_all_date_array[2])
      replaced_all_date_array.slice!(0, 3)
      end
      if replaced_all_date_array.size == 2
        rendering_string_result += merge_date_unit(2, replaced_all_date_array[0], replaced_all_date_array[1])
        replaced_all_date_array.slice!(0, 2)
      end
      if replaced_all_date_array.size == 1
        rendering_string_result += merge_date_unit(1, replaced_all_date_array[0])
        replaced_all_date_array.slice!(0, 1)
      end    
    when 2 
      while replaced_all_date_array.size / 2 >= 1 do
        rendering_string_result += merge_date_unit(2, replaced_all_date_array[0], replaced_all_date_array[1])
      replaced_all_date_array.slice!(0, 2)
      end
      if replaced_all_date_array.size == 1
        rendering_string_result += merge_date_unit(1, replaced_all_date_array[0])
        replaced_all_date_array.slice!(0, 1)
      end
    end

    rendering_string_result.insert(0, @layout_status[:header_position].call(@all_date_array[0][1]))
    rendering_string_result
  end

  def merge_date_unit(merge_unit_num, first_unit = nil, second_unit = nil, third_unit = nil)
    case merge_unit_num
    when 1
      first_unit_day_cells = first_unit[2]
  
      maxsize = [first_unit_day_cells.size].max
  
      if (28 <  maxsize && maxsize < 36) then
        column = 5
      else
        column = 6
      end
  
      while first_unit_day_cells.size < column * 7 do
        first_unit_day_cells << "#{@layout_status[:blank]}"
      end
  
      one_month_day_cells = Array.new(column).map{Array.new(14,nil)}
      one_month_day_cells.map.each_with_index do |element, index|
        element[0..6] = first_unit_day_cells[index * 7..index * 7 + 6]
      end
  
      one_month_days_string_result = join_days_string(one_month_day_cells, column)

      one_month_days_string_result = <<-"EOS"
#{@layout_status[:one_caption].call(first_unit[0], first_unit[1])}
#{@layout_status[:one_week]}
#{one_month_days_string_result}
        EOS
  
    when 2
      first_unit_day_cells = first_unit[2]
      second_unit_day_cells = second_unit[2]
  
      maxsize = [first_unit_day_cells.size, second_unit_day_cells.size].max
  
      if (28 <  maxsize && maxsize < 36) then
        column = 5
      else
        column = 6
      end
  
      while first_unit_day_cells.size < column * 7 do
        first_unit_day_cells << "#{@layout_status[:blank]} "
      end
      while second_unit_day_cells.size < column * 7 do
        second_unit_day_cells << "#{@layout_status[:blank]} "
      end
  
      two_months_day_cells = Array.new(column).map{Array.new(14,nil)}
      two_months_day_cells.map.each_with_index do |element, index|
        element[0..6] = first_unit_day_cells[index * 7..index * 7 + 6]
        element[7..13] = second_unit_day_cells[index * 7..index * 7 + 6]
  
        element.insert(7, " ")
      end
  
      two_month_days_string_result = join_days_string(two_months_day_cells, column)

      two_month_days_string_result = <<-"EOS"
#{@layout_status[:two_caption].call(first_unit[0], first_unit[1], second_unit[0], second_unit[1])}
#{@layout_status[:two_weeks]}
#{two_month_days_string_result}
        EOS

    when 3
      first_unit_day_cells = first_unit[2]
      second_unit_day_cells = second_unit[2]
      third_unit_day_cells = third_unit[2]

      maxsize = [first_unit_day_cells.size, second_unit_day_cells.size, third_unit_day_cells.size].max
  
      if (28 <  maxsize && maxsize < 36) then
        column = 5
      else
        column = 6
      end
  
      while first_unit_day_cells.size < column * 7 do
        first_unit_day_cells << "#{@layout_status[:blank]} "
      end
      while second_unit_day_cells.size < column * 7 do
        second_unit_day_cells << "#{@layout_status[:blank]} "
      end
      while third_unit_day_cells.size < column * 7 do
        third_unit_day_cells << "#{@layout_status[:blank]}"
      end
  
      three_months_day_cells = Array.new(column).map{Array.new(21,nil)}
      three_months_day_cells.map.each_with_index do |element, index|
        element[0..6] = first_unit_day_cells[index * 7..index * 7 + 6]
        element[7..13] = second_unit_day_cells[index * 7..index * 7 + 6]
        element[14..20] = third_unit_day_cells[index * 7..index * 7 + 6]
  
        element.insert(14, " ")
        element.insert(7, " ")
        end

        three_month_days_string_result = join_days_string(three_months_day_cells, column)
  
        three_month_days_string_result = <<-"EOS"
#{@layout_status[:three_caption].call(first_unit[0], first_unit[1], second_unit[0], second_unit[1], third_unit[0], third_unit[1])}
#{@layout_status[:three_weeks]}
#{three_month_days_string_result}
          EOS
      return three_month_days_string_result
    end
  end

  def join_days_string(day_cells, column)
    case column
    when 6
      join_days_string_result = <<-"EOS"
#{day_cells[0].join}
#{day_cells[1].join}
#{day_cells[2].join}
#{day_cells[3].join}
#{day_cells[4].join}
#{day_cells[5].join}
      EOS
    when 5
      join_days_string_result = <<-"EOS"
#{day_cells[0].join}
#{day_cells[1].join}
#{day_cells[2].join}
#{day_cells[3].join}
#{day_cells[4].join}
      EOS
    end
    return join_days_string_result
  end

  def replace_layout_var(all_date_array)
    all_date_array.each_with_index do |month, month_index|
      month[2].each_with_index do |element, day|
        if element == "blank "
          all_date_array[month_index][2][day] = "#{@layout_status[:blank]} "
        end
        if element.include?("blank_for_one_char")
          all_date_array[month_index][2][day] = element.gsub(/blank_for_one_char/, "#{@layout_status[:blank_for_one_char]}")
        end
        if element.include?("blank_for_two_char")
          all_date_array[month_index][2][day] = element.gsub(/blank_for_two_char/, "#{@layout_status[:blank_for_two_char]}")
        end
        if element.include?("blank_for_three_char")
          all_date_array[month_index][2][day] = element.gsub(/blank_for_three_char/, "#{@layout_status[:blank_for_three_char]}")
        end
      end
    end
  end

end
