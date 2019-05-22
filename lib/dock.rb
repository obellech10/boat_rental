class Dock
  attr_reader :name,
              :max_rental_time,
              :rental_log,
              :rental_charge

  def initialize(name, max_rental_time)
    @name = name
    @max_rental_time = max_rental_time
    @rental_log = {}
    @rental_charge = {}
  end

  def rent(boat_type, renter)
    @rental_log[boat_type] = renter
  end

  def charge(boat_type)
    rental_amount = (boat_type.hours_rented * boat_type.price_per_hour)
    renter_card = @rental_log[boat_type].credit_card_number
    @rental_charge[:card_number] = renter_card
    @rental_charge[:amount] = rental_amount
    @rental_charge
  end
end
