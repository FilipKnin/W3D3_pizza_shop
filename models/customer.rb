require_relative('../db/sqlrunner')

class Customer

  attr_accessor :first_name, :last_name
  attr_reader  :id

  def initialize(options)
    @first_name = options['first_name']
    @last_name = options['last_name']
    @id = options['id'].to_i if options['id']
  end

  def save()
    sql = "INSERT INTO customers
          (first_name, last_name)
          VALUES
           ($1, $2) RETURNING *"
    values = [@first_name, @last_name]
    @id = SqlRunner.run(sql, values)[0]['id'].to_i

    # db = PG.connect({ dbname: 'pizza_shop', host: 'localhost'})
    # sql = "INSERT INTO customers
    #       (first_name, last_name)
    #       VALUES
    #       ($1, $2) RETURNING *"
    # values = [@first_name, @last_name]
    # db.prepare("save", sql)
    # @id = db.exec_prepared("save", values)[0]['id'].to_i
    # db.close()
  end

  def delete()
    sql = "DELETE FROM customers WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)

    # db = PG.connect({ dbname: 'pizza_shop', host: 'localhost'})
    # sql = "DELETE FROM customers WHERE id = $1"
    # values = [@id]
    # db.prepare("delete_one", sql)
    # db.exec_prepared("delete_one", values)
    # db.close()
  end

  def update()
    sql = "UPDATE customers
            SET
            (
              first_name, last_name
            ) = (
              $1, $2
            )
            WHERE id = $3
              "
    values = [@first_name, @last_name, @id]
    SqlRunner.run(sql, values)
    # db = PG.connect({ dbname: 'pizza_shop', host: 'localhost'})
    # sql = "UPDATE customers
    #         SET
    #         (
    #           first_name, last_name
    #         ) = (
    #           $1, $2
    #         )
    #         WHERE id = $3
    #           "
    # values = [@first_name, @last_name, @id]
    # db.prepare("update", sql)
    # db.exec_prepared("update", values)
    # db.close()
  end

  def pizza_orders()
    sql = "SELECT * FROM pizza_orders
          WHERE
          customer_id = $1
          "
    values = [@id]
    list = SqlRunner.run(sql, values)

    # db = PG.connect({dbname: 'pizza_shop', host: 'localhost'})
    # sql = "SELECT * FROM pizza_orders
    #       WHERE
    #       customer_id = $1
    #       "
    # values = [@id]
    # db.prepare("order_list", sql)
    # list = db.exec_prepared("order_list", values)
    # db.close()
    return list.map { |order| PizzaOrder.new(order)}
  end

  def Customer.all()
    sql = "SELECT * FROM customers"
    customers = SqlRunner.run(sql)

    # db = PG.connect({ dbname: 'pizza_shop', host: 'localhost'})
    # sql = "SELECT * FROM customers"
    # db.prepare("all", sql)
    # customers = db.exec_prepared("all")
    # db.close()
    return customers.map{ |customer| Customer.new(customer)}
  end

end
