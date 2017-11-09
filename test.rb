require_relative 'factory'

# Test Factory
puts '----------FACTORY---------'

# Customer = Factory.new(:name, :address) do
#   def greeting
#     "Hello #{name}!"
#   end
# end
#
# dave = Customer.new("Dave", "123 Main")
# p dave.name
# p dave.greeting

# Factory.new("Customer", :name, :address)
# p Factory::Customer.new("Dave", "123 Main")

# Customer = Factory.new(:name, :address)
# p Customer.new("Dave", "123 Main")

# Customer = Factory.new(:name, :address) do
#   def greeting
#     "Hello #{name}!"
#   end
# end
# p Customer.new("Dave", "123 Main").greeting

Customer = Factory.new(:name, :address)
p Customer.new("Dave", "123 Main")
p Customer["Dave"]