require 'json'
require_relative 'models/customer'

EARTHS_RADIUS_KM = 6371
MAX_ALLOWED_DISTANCE = 100
INTERCOM_OFFICE_COORDINATES = {
  :latitude => 53.339428, 
  :longitude => -6.257664
}

def degrees_to_radians(degrees)
  degrees * Math::PI / 180
end

def distance_between_coordinates(lat1, lng1, lat2, lng2)
  lat1_radians = degrees_to_radians(lat1)
  lat2_radians = degrees_to_radians(lat2)
  lat_diff_radians = degrees_to_radians(lat2 - lat1)
  lng_diff_radians = degrees_to_radians(lng2 - lng1)

  a = Math.sin(lat_diff_radians/2) * Math.sin(lat_diff_radians/2) +
      Math.cos(lat1_radians) * Math.cos(lat2_radians) *
      Math.sin(lng_diff_radians/2) * Math.sin(lng_diff_radians/2)
  
  c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a))

  return EARTHS_RADIUS_KM * c
end

def get_customers_from_file(file_name)
  customers = File.open(file_name).read
  customers.each_line.collect do |customer|
    begin
      customer_json = JSON.parse(customer)
      Customer.new(name: customer_json['name'], 
                  user_id: customer_json['user_id'].to_i, 
                  latitude: customer_json['latitude'].to_f, 
                  longitude: customer_json['longitude'].to_f)
    rescue Exception => e
      raise "JSON parse error: #{e}"
    end
  end
end

def filter_customers(customers)
  customers.select do |customer|

    distance = distance_between_coordinates(INTERCOM_OFFICE_COORDINATES[:latitude], 
                                          INTERCOM_OFFICE_COORDINATES[:longitude], 
                                          customer.latitude, 
                                          customer.longitude) 
    distance <= MAX_ALLOWED_DISTANCE
  end  
end

def print_customers(customers)
  customers.each {|customer| puts customer }
end
