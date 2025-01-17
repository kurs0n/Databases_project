-- Migration file: 003_add_transactions.sql

-- This migration file demonstrates the usage of transactions
-- and different isolation levels in PostgreSQL.

-- Example 1: Simple Transaction with Commit
-- This transaction adds a new order and its associated payment.
BEGIN;
  INSERT INTO Orders (customer_id, order_date, status)
  VALUES (1, CURRENT_DATE, 'Pending') RETURNING order_id;

  INSERT INTO Payments (order_id, payment_date, amount, payment_status, payment_method)
  VALUES (1, CURRENT_DATE, 100.00, 'Unpaid', 'card');

COMMIT;

-- Example 2: Transaction with Repeatable Read Isolation Level
-- This transaction updates inventory and adds an order item,
-- ensuring consistent inventory levels.
BEGIN;
  SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;

  SELECT stock_quantity FROM Inventory WHERE product_id = 1 AND size = 'M';

  UPDATE Inventory SET stock_quantity = 9 WHERE product_id = 1 AND size = 'M';

  INSERT INTO Order_items (order_id, product_id, quantity, product_price)
  VALUES (1, 1, 1, 100.00);

COMMIT;

-- Example 3: Transaction with Rollback due to payment failure
-- This simulates a scenario where a payment fails,
-- requiring the order to be rolled back.
BEGIN;
  INSERT INTO Orders (customer_id, order_date, status)
  VALUES (1, CURRENT_DATE, 'Pending') RETURNING order_id;

  -- Simulate payment error
  -- INSERT INTO Payments (order_id, payment_date, amount, payment_status, payment_method)
  -- VALUES (1, CURRENT_DATE, 100.00, 'Paid', 'card');

  ROLLBACK;

-- Example 4: Transaction with Serializable level to prevent phantom reads
-- Demonstrating how serializable isolation level prevents phantom reads
BEGIN;
  SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

  SELECT * FROM Inventory;

  INSERT INTO Inventory (product_id, size, stock_quantity)
  VALUES (2, 'L', 20);

COMMIT;


-- Example 5: Transaction for adding an invoice for an order
BEGIN;
    -- Step 1: Check if the order has a payment
    SELECT payment_status FROM payments WHERE order_id = 1;

    -- Step 2: Create an invoice for the order
    INSERT INTO Invoices (customer_id, order_id, invoice_number, invoice_date, billing_address_id, total_amount, status)
    VALUES (1, 1, 'INV-2023-10-001', CURRENT_DATE, 1, 100.00, 'Pending');

    -- Step 3: Optionally update order status to 'Invoiced' or similar
    -- UPDATE Orders SET status = 'Invoiced' WHERE order_id = 1;

COMMIT;

-- Example 6: Transaction for adding a customer with addresses.
BEGIN;
    -- Step 1: Create Billing Address
    INSERT INTO Addresses (street, city, building_number, flat_number, postal_code, country, type)
    VALUES ('Nowa', 'Warszawa', 10, 2, '00-123', 'Poland', 'house') RETURNING address_id;

    -- Step 2: Save billing address id
    -- This is an example where in code you would return and get the address_id from insert above
    -- so you would use it in following insert
    -- SELECT MAX(address_id) from Addresses;

    -- Step 3: Create Shipping Address
    INSERT INTO Addresses (street, city, building_number, flat_number, postal_code, country, type)
    VALUES ('Stara', 'Warszawa', 20, 3, '00-456', 'Poland', 'house') RETURNING address_id;

    -- Step 4: Save shipping address id (like in step 2)
    -- SELECT MAX(address_id) from Addresses;

    -- Step 5: Create a new customer with those addresses
    INSERT INTO Customers (name, surname, email, billing_address_id, shipping_address_id)
    VALUES ('Adam', 'Kowalski', 'adam.kowalski@example.com', 1, 2);

COMMIT;

-- Example 7: Transaction for handling opinions
BEGIN;
    -- Step 1: Add the new opinion
    INSERT INTO Opinions (product_id, customer_id, rating, comment)
    VALUES (1, 1, 5, 'Very good product.');

    -- Step 2: Calculate the average rating for the product
    SELECT product_id, AVG(rating) FROM Opinions WHERE product_id = 1 GROUP BY product_id;

    -- You might have additional logic here, like updating a product rating if such a column exists.
    -- This is where the level of isolation becomes important. If the average rating is used in other places
    -- then repeatable read, or higher, could prevent race conditions between other operations.
COMMIT;

-- Example 8: Transaction for updating multiple order items and total amount
BEGIN;
  -- Start transaction
  SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
  
    -- Step 1: Fetch all the order items for an order
    SELECT * FROM order_items WHERE order_id = 1;

    -- Step 2: Update quantities and prices for the items
    UPDATE Order_Items SET quantity = 2, product_price = 110.00 WHERE order_item_id = 1;
    UPDATE Order_Items SET quantity = 3, product_price = 120.00 WHERE order_item_id = 2;

    -- Step 3: Re-calculate the total order amount (you'll need to join with `Orders` table if you want to update there)
    SELECT sum(product_price * quantity) FROM order_items WHERE order_id = 1;


  -- Commit transaction
COMMIT;

-- Example 9: Transaction for updating customer information and related addresses
BEGIN;
    SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;

    -- Step 1: Get current customer info
    SELECT * from customers WHERE customer_id = 1;

    -- Step 2: Update customer details
    UPDATE Customers SET phone_number = '123-456-789', email = 'test@example.com'  WHERE customer_id = 1;

    -- Step 3: Update billing address
    UPDATE Addresses SET street = 'Updated Address' WHERE address_id = (SELECT billing_address_id from customers WHERE customer_id = 1);

    -- Step 4: Update shipping address
    UPDATE Addresses SET city = 'Updated City' WHERE address_id = (SELECT shipping_address_id from customers WHERE customer_id = 1);
    
    -- Step 5: Check data
    SELECT * from customers WHERE customer_id = 1;

    SELECT * from addresses WHERE address_id = (SELECT billing_address_id from customers WHERE customer_id = 1);
    SELECT * from addresses WHERE address_id = (SELECT shipping_address_id from customers WHERE customer_id = 1);
COMMIT;

-- Example 10: Using savepoints to allow for partial rollbacks
BEGIN;
  -- Begin Transaction
  INSERT INTO Products(name, description, regular_price, actual_price, size, color, sex)
    VALUES ('Test product 1','Test product 1 description', 20.00, 15.00, 'M', 'Blue', 'Unisex');
    
  SAVEPOINT first_insert;
  
  INSERT INTO Products(name, description, regular_price, actual_price, size, color, sex)
    VALUES ('Test product 2','Test product 2 description', 20.00, 15.00, 'L', 'Green', 'Female');
    
  -- Simulate Error (e.g. a missing field)
  -- INSERT INTO Products(name, description, regular_price, actual_price, color, sex)
  --   VALUES ('Test product 3','Test product 3 description', 20.00, 15.00, 'Red', 'Male');
   
   -- rollback to our savepoint and continue
   ROLLBACK TO first_insert;
   
  INSERT INTO Products(name, description, regular_price, actual_price, size, color, sex)
    VALUES ('Test product 3','Test product 3 description', 20.00, 15.00, 'S', 'Red', 'Male');

  -- Commit transaction
  COMMIT;
