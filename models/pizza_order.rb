require_relative('../db/sqlrunner')

class PizzaOrder

  attr_reader :id, :customer_id
  attr_accessor :first_name, :last_name, :quantity, :topping

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @customer_id = options['customer_id'].to_i
    @quantity  = options['quantity'].to_i
    @topping = options['topping']
  end

  def save()
    sql = "INSERT INTO pizza_orders
          (customer_id, quantity, topping)
          VALUES
          ($1, $2, $3) RETURNING *"
    values = [@customer_id, @quantity, @topping]
    @id = SqlRunner.run(sql, values)[0]['id'].to_i
    # db = PG.connect({ dbname: 'pizza_shop', host: 'localhost'})
    # sql = "INSERT INTO pizza_orders
    #       (customer_id, quantity, topping)
    #       VALUES
    #       ($1, $2, $3) RETURNING *"
    # values = [@customer_id, @quantity, @topping]
    # db.prepare("save", sql)
      # the db.exec_prepared does the thing it's instructed to
      #even though it's only returning just a bit of the entire row
      #it's inserted it already
    # @id= db.exec_prepared("save", values)[0]['id'].to_i
    # db.close()
  end

  def delete()
    sql = "DELETE FROM pizza_orders WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
    # db = PG.connect({ dbname: 'pizza_shop', host: 'localhost'})
    # sql = "DELETE FROM pizza_orders WHERE id = $1"
    # values = [@id]
    # db.prepare("delete_one", sql)
    # db.exec_prepared("delete_one", values)
    # db.close()
  end

  def update()
    sql = "UPDATE pizza_orders
            SET
            (
              first_name, last_name, quantity, topping
            ) = (
              $1, $2, $3, $4
            )
            WHERE id = $5
              "
    values = [@first_name, @last_name, @quantity, @topping, @id]
    SqlRunner.run(sql, values)
    # db = PG.connect({ dbname: 'pizza_shop', host: 'localhost'})
    # sql = "UPDATE pizza_orders
    #         SET
    #         (
    #           first_name, last_name, quantity, topping
    #         ) = (
    #           $1, $2, $3, $4
    #         )
    #         WHERE id = $5
    #           "
    # values = [@first_name, @last_name, @quantity, @topping, @id]
    # db.prepare("update", sql)
    # db.exec_prepared("update", values)
    # db.close()
  end

  def customer()
    sql = "SELECT * FROM customers
       WHERE
       id = $1
       "
    values = [@customer_id]
    cust = SqlRunner.run(sql, values)
    # db = PG.connect({dbname: 'pizza_shop', host: 'localhost'})
    # sql = "SELECT * FROM customers
    #    WHERE
    #    id = $1
    #    "
    # values = [@customer_id]
    # db.prepare("customer", sql)
    # cust = db.exec_prepared("customer", values)
    # db.close()
    return cust.map { |order| Customer.new(order)}[0]
  end

  def PizzaOrder.all()
    sql = "SELECT * FROM pizza_orders"
    orders = SqlRunner.run(sql)
    # you can use self.all, it's the same thing
    # db = PG.connect({ dbname: 'pizza_shop', host: 'localhost'})
    # sql = "SELECT * FROM pizza_orders"
    # db.prepare("all", sql)
    # orders = db.exec_prepared("all")
    # db.close()
    return orders.map{ |order| PizzaOrder.new(order)}
  end

  def PizzaOrder.delete_all()
    sql = "DELETE FROM pizza_orders"
    SqlRunner.run(sql)
    # db = PG.connect({ dbname: 'pizza_shop', host: 'localhost'})
    # sql = "DELETE FROM pizza_orders"
    # db.prepare("delete_all", sql)
    # db.exec_prepared("delete_all")
    # db.close()
  end

end
