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

# Customer = Factory.new(:name, :address)
# p Customer.new("Dave", "123 Main")
# p Customer["Dave"]

# Customer = Factory.new(:name, :address, :zip)
# joe   = Customer.new("Joe Smith", "123 Maple, Anytown NC", 12345)
# joejr = Customer.new("Joe Smith", "123 Maple, Anytown NC", 12345)
# jane  = Customer.new("Jane Doe", "456 Elm, Anytown NC", 12345)
# p joe
# p joejr
# p jane
# p joe == joejr   #=> true
# p joe == jane    #=> false

# Customer = Factory.new(:name, :address, :zip)
# joe = Customer.new("Joe Smith", "123 Maple, Anytown NC", 12345)
#
# p joe["name"]   #=> "Joe Smith"
# p joe[:name]    #=> "Joe Smith"
# p joe[0]        #=> "Joe Smith"

# Customer = Struct.new(:name, :address, :zip)
# joe = Customer.new("Joe Smith", "123 Maple, Anytown NC", 12345)
#
# joe["name"] = "Luke"
# joe[:zip]   = "90210"
#
# p joe.name   #=> "Luke"
# p joe.zip    #=> "90210"
#
# p joe.members
# p joe.values
# p joe.to_a
# p joe.size
