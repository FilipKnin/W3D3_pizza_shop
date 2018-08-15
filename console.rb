require('pry-byebug')
require_relative('models/pizza_order')
require_relative('models/customer')

PizzaOrder.delete_all()
# Customer.delete_all()

customer1 = Customer.new( {
  'first_name' => 'Darth',
  'last_name' => 'Vader'
  })

  customer1.save()

order1 = PizzaOrder.new( {
  'customer_id' => customer1.id,
  'quantity' => '1',
  'topping' => 'Napoli'
  })

  order2 = PizzaOrder.new( {
    'customer_id' => customer1.id,
    'quantity' => '1',
    'topping' => 'Napoli'
    })

order1.save
order2.save



# order1.delete
# order2.delete
# customer1.delete



#EVIL ORDER
# order3 = PizzaOrder.new({
#   “first_name” => “Darth”,
#   “last_name” => “Vader”,
#   “quantity” => “1",
#   “topping” => “); DELETE FROM pizza_orders;--”
#   })


# orders = PizzaOrder.all()

binding.pry
nil
