require 'optparse'
require 'date'
require './optparse_conditions.rb'

class OptparseRun
  attr_accessor :keys_result
  include OptparseConditions

  THIS_Y = Date.today.year
  THIS_M = Date.today.mon
  THIS_D = Date.today.day
  THIS_W = Date.today.wday

  def initialize(keys)
    @keys = keys
    p @keys_result = @keys
    prepare_optparse_comditions
  end
  
  def optparse_run
    this_argv_parser = OptionParser.new

    opt_execution_record = {}

    this_argv_parser.on('-y [VAL]') do | v |
      # p ARGV[1]
      @index = ARGV.find_index("-y")
      # p two_num_after_opt(ARGV, @index)

      # エラーコメントを日本語にして、true判定の記述は消す

      if (opt_has_two_numbers(ARGV, @index) == true && num_is_between_1_and_12(ARGV, @index) == false) then
        puts "#{ARGV[@index + 1]} is neither a month number (1..12) nor a name"
        exit
      elsif opt_has_two_numbers(ARGV, @index) == true then
        puts "-y together a given month is not supported."
        exit
      # elsif first_num_is_between_1_and_12(ARGV, @index) == false then
      #   puts "#{ARGV[@index + 1]} is neither a month number (1..12) nor a name"
      #   exit
      # elsif invalid_option(ARGV, "-y") == true #ここoptparseがエラー出してくれるっぽいから後回し？
      else
        
      end

      if (ARGV[1] != nil) then
        @keys_result[:next_month] = 11
        @keys_result[:basic_month] = 1
        @keys_result[:basic_year] = v.to_i
      else
        @keys_result[:next_month] = 11
        @keys_result[:basic_month] = 1
        @keys_result[:basic_year] = THIS_Y
      end
      puts "\n"
      puts "-y オプションが実行されました"
      puts "現在のリクエストアレイは#{@keys_result}です"
      puts "\n"
    end

    this_argv_parser.on('-m VAL') do | v |
      @index = ARGV.find_index("-m")

      # このエラーはなくてもいい？
      if some_opt_after_this_opt(ARGV, "-m") == true
        puts "-mオプションの直後には年を入力してください"
        exit
      end

      if (opt_has_one_number(ARGV, @index) && num_is_between_1_and_12(ARGV, @index)) then
        @keys_result[:basic_month] = ARGV[1].to_i
        @keys_result[:basic_year] = THIS_Y
        puts "引数は月のみ"
        
      elsif (opt_has_month_and_year(ARGV, @index)) then
        @keys_result[:basic_month] = ARGV[1].to_i
        @keys_result[:basic_year] = ARGV[2].to_i
        puts "引数は年月"
      else
      end
      puts "\n"
      puts "-m オプションが実行されました"
      puts "現在のリクエストアレイは#{@keys_result}です"
      puts "\n"
    end

    this_argv_parser.on('-3') do | v |
      @index = ARGV.find_index("-3")
      @conflicting_opt_list = ["-y", "-A", "-B"]

      @keys_result[:pre_month] = 1
      @keys_result[:pre_year] = THIS_Y
      @keys_result[:next_month] = 1
      @keys_result[:next_year] = THIS_Y
      # opt_has_two_numbers(ARGV, @index) && num_is_between_1_and_12(ARGV, @index) == false

      if (opt_has_two_numbers(ARGV, @index) && !num_is_between_1_and_12(ARGV, @index))
        p "月は1から12の間で入力してください"
        exit
      elsif this_argv_has_conflicting_opt(ARGV, @conflicting_opt_list)
        p "これらのオプションは同時に使えません"
        exit
      elsif opt_has_one_number(ARGV, @index)
        puts "年を入力してください"
        exit
      else
      end

      if (opt_has_two_numbers(ARGV, @index) && num_is_between_1_and_12(ARGV, @index) && num_is_between_1_and_9999(ARGV, @index)) then
        @keys_result[:basic_month] = ARGV[1].to_i
        @keys_result[:basic_year] = ARGV[2].to_i
        @keys_result[:pre_month] = 1
        @keys_result[:pre_year] = ARGV[2].to_i
        @keys_result[:next_month] = 1
        @keys_result[:next_year] = ARGV[2].to_i
      end
      puts "\n"
      puts "-3 オプションが実行されました"
      puts "現在のリクエストアレイは#{@keys_result}です"
      puts "\n"
    end

    this_argv_parser.on('-A VAL') do | v |
      @index = ARGV.find_index("-A")

      if opt_has_two_numbers(ARGV, @index)
        puts "このオプションでは年を指定できません"
        exit
      end

      @keys_result[:next_month] = v.to_i
      puts "\n"
      puts "-A オプションが実行されました"
      puts "現在のリクエストアレイは#{@keys_result}です"
      puts "\n"
    end

    this_argv_parser.on('-B VAL') do | v |
      @index = ARGV.find_index("-B")

      if opt_has_two_numbers(ARGV, @index)
        puts "このオプションでは年を指定できません"
        exit
      end

      @keys_result[:pre_month] = v.to_i
      puts "\n"
      puts "-B オプションが実行されました"
      puts "現在のリクエストアレイは#{@keys_result}です"
      puts "\n"

    end

    this_argv_parser.on('-j') do | v |
      @keys_result[:julius] = true
      puts "\n"
      puts "-j オプションが実行されました"
      puts "現在のリクエストアレイは#{@keys_result}です"
      puts "Juliusで表示します。"
      puts "\n"
    end

    this_argv_parser.on('-h') do | v |
      @keys_result[:highligth] = false
      puts "\n"
      puts "-h オプションが実行されました"
      puts "現在のリクエストアレイは#{@keys_result}です"
      puts "ハイライトオフ"
      puts "\n"
    end

    this_argv_parser.parse(ARGV)
    
    if (ARGV.empty? == true) then
      puts "\n"
      p "オプション指定なし。今月のカレンダーを表示します。"
      puts "現在のリクエストアレイは#{@keys_result}です"
      puts "\n"
    end

    if (ARGV.size == 1 && 0 == (ARGV[0] =~ /\d{1,4}/) && 1 <= ARGV[0].to_i && ARGV[0].to_i <= 9999)
      @keys_result[:basic_year] = ARGV[0].to_i
      puts "\n"
      p "デフォルトオプション[year]が実行されます"
      puts "現在のリクエストアレイは#{@keys_result}です"
      puts "\n"
    end

    if (ARGV.size == 2 && 0 == (ARGV[0] =~ /\d{1,2}/) && 0 == (ARGV[0] =~ /\d{1,4}/) && 1 <= ARGV[1].to_i && ARGV[1].to_i <= 9999 && 1 <= ARGV[0].to_i && ARGV[0].to_i <= 12)
      @keys_result[:basic_month] = ARGV[0].to_i
      @keys_result[:basic_year] = ARGV[1].to_i
      puts "\n"
      p "デフォルトオプション[[month]year]が実行されます"
      puts "現在のリクエストアレイは#{@keys_result}です"
      puts "\n"
    end

    return @keys_result
  end
end

