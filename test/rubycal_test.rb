require 'minitest/autorun'
require_relative '../lib/rubycal.rb'

class RubyCal < Minitest::Test
  def setup
    @rubycal = Rubycal.new
  end

  def test_rubycal
    assert_equal "", @rubycal.optparse
  end
end