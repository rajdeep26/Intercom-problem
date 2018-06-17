require "test/unit"
require_relative '../functions'
require_relative '../models/customer'

class MainTest < Test::Unit::TestCase
 
  def test_distance_between_coordinates_function
    assert_equal(111.03948272591826, distance_between_coordinates(38.898556, -77.037852, 39.897147, -77.043934))
    assert_equal(30.96484198266178, distance_between_coordinates(15.6002, 73.8125, 15.3991, 74.0124))
  end

  def test_degres_to_radians
    assert_equal(0.017453292519943295, degrees_to_radians(1))
  end

  def test_customer_latitude_longitude_type
    exception = assert_raises { Customer.new(latitude: '54.0894797', user_id: 8, name: "Eoin Ahearn", longitude: -6.18671) }
    assert('latitude should be Numeric value', exception.message)

    exception = assert_raises { Customer.new(latitude: 54.0894797, user_id: 8, name: "Eoin Ahearn", longitude: '-6.18671') }
    assert('longitude should be Numeric value', exception.message)
  end

  def test_reading_customers_from_file
    expected_customers = [
      Customer.new(latitude: 54.0894797, user_id: 8, name: "Eoin Ahearn", longitude: -6.18671),
      Customer.new(latitude: 53.038056, user_id: 26, name: "Stephen McArdle", longitude: -7.653889),
      Customer.new(latitude: 54.1225, user_id: 27, name: "Enid Gallagher", longitude: -8.143333)
    ]
    customers = get_customers_from_file('tests/fixtures/customers.txt')
    assert_equal(3, customers.count)
    assert_equal(expected_customers, customers.sort_by {|c| c.user_id })
  end

  def test_filter_customers_logic
    customers = [
      Customer.new(latitude: 52.3191841, user_id: 3, name: "Jack Enright", longitude: -8.5072391),
      Customer.new(latitude: 52.2559432, user_id: 9, name: "Jack Dempsey", longitude: -7.1048927),
      Customer.new(latitude: 52.986375, user_id: 12, name: "Christina McArdle", longitude: -6.043701),
      Customer.new(latitude: 53.1489345, user_id: 31, name: "Alan Behan", longitude: -6.8422408)
    ]

    expected_customers = [
      Customer.new(latitude: 52.986375, user_id: 12, name: "Christina McArdle", longitude: -6.043701),
      Customer.new(latitude: 53.1489345, user_id: 31, name: "Alan Behan", longitude: -6.8422408)
    ]

    filtered_customers = filter_customers(customers)
    assert_equal(2, filtered_customers.count)
    assert_equal(expected_customers, filtered_customers.sort_by {|c| c.user_id })
  end
  
end