require 'optparse'
require 'date'

class OptparseRun
  attr_accessor :request_result

  THIS_Y = Date.today.year
  THIS_M = Date.today.mon
  THIS_D = Date.today.day
  THIS_W = Date.today.wday

  def request_result_initialize
    @request_result = { 
      basic_month: THIS_M,
      basic_year: THIS_Y,
      basic_day: THIS_D,
      pre_month: nil,
      pre_year: nil,
      next_month: nil,
      next_year: nil,
      julius: false,
      highligth: true,
    }

    
  end
  
  def run
    rb_cal_request_opt = OptionParser.new
    request_result_initialize

    rb_cal_request_opt.on('-y [VAL]') do | v |
      p ARGV[1]
      if (ARGV[1] != nil) then
        @request_result[:next_month] = 11
        @request_result[:basic_month] = 1
        @request_result[:basic_year] = v.to_i
      else
        @request_result[:next_month] = 11
        @request_result[:basic_month] = 1
        @request_result[:basic_year] = THIS_Y
        
      end
      puts "\n"
      puts "-y オプションが実行されました"
      puts "現在のリクエストアレイは#{@request_result}です"
      puts "\n"
    end

    rb_cal_request_opt.on('-m VAL') do | v |
      if (ARGV.size == 2 && 0 == (ARGV[1] =~ /\d{1,2}/) && 1 <= ARGV[1].to_i && ARGV[1].to_i <= 12) then
        @request_result[:basic_month] = ARGV[1].to_i
        @request_result[:basic_year] = THIS_Y
        puts "引数は月のみ"
        
      elsif (ARGV.size == 3 && 0 == (ARGV[1] =~ /\d{1,2}/) && 1 <= ARGV[1].to_i && ARGV[1].to_i <= 12 && 0 == (ARGV[2] =~ /\d{1,4}/) && 1 <= ARGV[2].to_i && ARGV[2].to_i <= 9999) then
        @request_result[:basic_month] = ARGV[1].to_i
        @request_result[:basic_year] = ARGV[2].to_i
        puts "引数は年月"
      else
      end
      puts "\n"
      puts "-m オプションが実行されました"
      puts "現在のリクエストアレイは#{@request_result}です"
      puts "\n"
    end

    rb_cal_request_opt.on('-3') do | v |
      @request_result[:pre_month] = 1
      @request_result[:pre_year] = THIS_Y
      @request_result[:next_month] = 1
      @request_result[:next_year] = THIS_Y

      if (ARGV.size == 3 && 0 == (ARGV[1] =~ /\d{1,2}/) && 1 <= ARGV[1].to_i && ARGV[1].to_i <= 12 && 0 == (ARGV[2] =~ /\d{1,4}/) && 1 <= ARGV[2].to_i && ARGV[2].to_i <= 9999) then
        @request_result[:basic_month] = ARGV[1].to_i
        @request_result[:basic_year] = ARGV[2].to_i
        @request_result[:pre_month] = 1
        @request_result[:pre_year] = ARGV[2].to_i
        @request_result[:next_month] = 1
        @request_result[:next_year] = ARGV[2].to_i
      end
      puts "\n"
      puts "-3 オプションが実行されました"
      puts "現在のリクエストアレイは#{@request_result}です"
      puts "\n"
    end

    rb_cal_request_opt.on('-A VAL') do | v |
      @request_result[:next_month] = v.to_i
      puts "\n"
      puts "-A オプションが実行されました"
      puts "現在のリクエストアレイは#{@request_result}です"
      puts "\n"
    end

    rb_cal_request_opt.on('-B VAL') do | v |
      @request_result[:pre_month] = v.to_i
      puts "\n"
      puts "-B オプションが実行されました"
      puts "現在のリクエストアレイは#{@request_result}です"
      puts "\n"

    end

    rb_cal_request_opt.on('-j') do | v |
      @request_result[:julius] = true
      puts "\n"
      puts "-j オプションが実行されました"
      puts "現在のリクエストアレイは#{@request_result}です"
      puts "Juliusで表示します。"
      puts "\n"
    end

    rb_cal_request_opt.on('-h') do | v |
      @request_result[:highligth] = false
      puts "\n"
      puts "-h オプションが実行されました"
      puts "現在のリクエストアレイは#{@request_result}です"
      puts "ハイライトオフ"
      puts "\n"
    end

    rb_cal_request_opt.parse(ARGV)
    
    if (ARGV.empty? == true) then
      puts "\n"
      p "オプション指定なし。今月のカレンダーを表示します。"
      puts "現在のリクエストアレイは#{@request_result}です"
      puts "\n"
    end

    if (ARGV.size == 1 && 0 == (ARGV[0] =~ /\d{1,4}/) && 1 <= ARGV[0].to_i && ARGV[0].to_i <= 9999)
      @request_result[:basic_year] = ARGV[0].to_i
      puts "\n"
      p "デフォルトオプション[year]が実行されます"
      puts "現在のリクエストアレイは#{@request_result}です"
      puts "\n"
    end

    if (ARGV.size == 2 && 0 == (ARGV[0] =~ /\d{1,2}/) && 0 == (ARGV[0] =~ /\d{1,4}/) && 1 <= ARGV[1].to_i && ARGV[1].to_i <= 9999 && 1 <= ARGV[0].to_i && ARGV[0].to_i <= 12)
      @request_result[:basic_month] = ARGV[0].to_i
      @request_result[:basic_year] = ARGV[1].to_i
      puts "\n"
      p "デフォルトオプション[[month]year]が実行されます"
      puts "現在のリクエストアレイは#{@request_result}です"
      puts "\n"
    end

    return @request_result
  end
end

