DROP TABLE IF EXISTS pizza_orders;
DROP TABLE IF EXISTS customers;

CREATE TABLE customers(
  id SERIAL8 PRIMARY KEY,
  first_name VARCHAR(255) NOT NULL,
  last_name VARCHAR(255) NOT NULL
);

CREATE TABLE pizza_orders(
  id SERIAL8 PRIMARY KEY,
  customer_id INT2 REFERENCES customers(id),
  quantity INT2 NOT NULL,
  topping VARCHAR(255) NOT NULL
);
