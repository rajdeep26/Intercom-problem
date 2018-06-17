require_relative 'functions'

customers = get_customers_from_file('data/customers.txt')
selected_customers = filter_customers(customers)
selected_customers.sort_by! {|customer| customer.user_id }
puts "Customers shortlised for some food and drinks: "
print_customers(selected_customers)