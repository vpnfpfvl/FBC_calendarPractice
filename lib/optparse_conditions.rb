module OptparseConditions
  def prepare_optparse_comditions
    p "たちあげたよ"
    # @two_num_after_opt = Proc.new do |argv|
    #   argv[opt_element_num.to_i + 1] = /\d+/ && argv[opt_element_num.to_i + 2] = /\d+/
    # end
    
  end

  def opt_has_two_numbers(argv, opt_index_num)
    (/^\d+$/ === argv[opt_index_num + 1].to_s && /^\d+$/ === argv[opt_index_num.to_i + 2].to_s)
  end

  def opt_has_one_number(argv, opt_index_num)
    (/^\d+$/ === argv[opt_index_num + 1].to_s && argv[opt_index_num + 2] == nil)
  end

  def num_is_between_1_and_12(argv, opt_index_num)
    argv[opt_index_num + 1].to_i.between?(1, 12)
  end

  def num_is_between_1_and_9999(argv, opt_index_num)
    argv[opt_index_num + 2].to_i.between?(1, 9999)
  end

  def some_opt_after_this_opt(argv, opt)
    argv.each do |element|
      if (/#{opt}[a-z]+$/ === element) # ここ、doをつけるとダメになる
        p "ここ"
        return true
      end
    end
  end

  def opt_has_month_and_year(argv, opt_index_num)
    (ARGV.size == 3 && 0 == (ARGV[1] =~ /\d{1,2}/) && 1 <= ARGV[1].to_i && ARGV[1].to_i <= 12 && 0 == (ARGV[2] =~ /\d{1,4}/) && 1 <= ARGV[2].to_i && ARGV[2].to_i <= 9999) #
  end

  def this_argv_has_conflicting_opt(argv, conflicting_opt_list)
    conflicting_opt = argv & conflicting_opt_list
    !conflicting_opt.empty?
  end

  def invalid_option(argv, opt)
    # case opt
    # when "-y"
    #   argv.include?("-m")
    # end
  end

end
