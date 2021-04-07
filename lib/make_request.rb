require './optparser_run.rb'

class MakeRequest

  def make_this_request
    this_request = parse_and_generate_request
    return this_request
  end

  def parse_and_generate_request
    OptparseRun.new.run
  end


end