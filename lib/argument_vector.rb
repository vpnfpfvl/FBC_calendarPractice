require './optparse_run.rb'

class ArgumentVector
  def get_request_status(keys)
    @keys = keys
    status_result = parse_this_argv
    
    status_result
  end

  private
  def parse_this_argv
    parse_this_arge = OptparseRun.new(@keys)
    result_this_parse = parse_this_arge.optparse_run
  end

end