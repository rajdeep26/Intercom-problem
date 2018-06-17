class Customer
  attr_accessor :name, :user_id, :latitude, :longitude

  def initialize(name:, user_id:, latitude:, longitude:)
    @name = name
    @user_id = user_id

    raise "latitude should be Numeric value" unless latitude.is_a?(Numeric)
    @latitude = latitude

    raise "longitude should be Numeric value" unless longitude.is_a?(Numeric)
    @longitude = longitude
  end

  def ==(customer)
    self.name == customer.name &&
    self.user_id == customer.user_id &&
    self.latitude == customer.latitude &&
    self.longitude == customer.longitude
  end

  def to_s
    "##{self.user_id}  #{self.name}"
  end
end