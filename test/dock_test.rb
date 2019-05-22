require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require './lib/boat'
require './lib/renter'
require './lib/dock'

class DockTest < MiniTest::Test

  def setup
    @dock = Dock.new("The Rowing Dock", 3)
    @kayak_1 = Boat.new(:kayak, 20)
    @kayak_2 = Boat.new(:kayak, 20)
    @sup_1 = Boat.new(:standup_paddle_board, 15)
    @patrick = Renter.new("Patrick Star", "4242424242424242")
    @eugene = Renter.new("Eugene Crabs", "1313131313131313")
  end

  def test_it_exists
    assert_instance_of Dock, @dock
  end

  def test_its_attributes
    assert_equal "The Rowing Dock", @dock.name
    assert_equal 3, @dock.max_rental_time
  end

  def test_dock_can_be_rented
    @dock.rent(@kayak_1, @patrick)
    @dock.rent(@kayak_2, @patrick)
    @dock.rent(@sup_1, @eugene)

    rentals = {@kayak_1 => @patrick, @kayak_2 => @patrick, @sup_1 => @eugene}
    assert_equal rentals, @dock.rental_log
  end

  def test_dock_can_charge_for_rental
    @dock.rent(@kayak_1, @patrick)
    @dock.rent(@kayak_2, @patrick)
    @dock.rent(@sup_1, @eugene)

    @kayak_1.add_hour
    @kayak_1.add_hour

    rental_charge = {card_number: "4242424242424242", amount: 40}
    assert_equal rental_charge, @dock.charge(@kayak_1)
  end

  def test_dock_cant_charge_more_than_max_hours
    @dock.rent(@sup_1, @eugene)

    @sup_1.add_hour
    @sup_1.add_hour
    @sup_1.add_hour
    @sup_1.add_hour
    @sup_1.add_hour

    rental_charge = {card_number: "1313131313131313", amount: 45}
    assert_equal rental_charge, @dock.charge(@sup_1)
  end
end
