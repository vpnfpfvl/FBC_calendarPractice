# require './make_request.rb'
require './optparse_run.rb'

class ArgumentVector
  attr_accessor :keys
                
  def get_request_status(keys)
    @keys = keys
    status_result = parse_this_argv
    
    argv_get_helper

    return status_result
  end

  def parse_this_argv
    parse_this_arge = OptparseRun.new(@keys)
    result_this_parse = parse_this_arge.optparse_run
    return result_this_parse
  end

  def argv_get_helper
    generate_instans_val_from_keys(@keys)

    @keys.each do |k|
      self.class.send(:define_method, "#{k}_get") { "#{k.to_s}" } ##ここはあとでシンボルハッシュとvalueを返すようにする
    end
    basic_month = "これ"
  end

  def generate_instans_val_from_keys(keys)
    keys.each do |k|
      "@#{k.to_s}"
    end
  end

  def choose_get(k)
    send("#{k}_get")
  end
end