require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/boat'
require 'pry'

class BoatTest < MiniTest::Test

  def setup
    @kayak = Boat.new(:kayak, 20)
  end

  def test_it_exists
    assert_instance_of Boat, @kayak
  end

  def test_its_attributes
    assert_equal :kayak, @kayak.type
    assert_equal 20, @kayak.price_per_hour
    assert_equal 0, @kayak.hours_rented
  end

  def test_it_can_be_rented
    @kayak.add_hour
    @kayak.add_hour
    @kayak.add_hour

    assert_equal 3, @kayak.hours_rented
  end
end
