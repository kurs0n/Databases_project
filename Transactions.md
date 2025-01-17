## Database Transaction Examples

This section outlines the transaction examples demonstrated in the `transactions.sql` migration file. These examples showcase the use of transactions with different isolation levels and error handling techniques to ensure data integrity.

### Transaction Examples

1.  **Simple Transaction with Commit:**
    *   **Functionality:** This transaction adds a new order and its associated payment.
    *   **Use Case:** This shows how to group multiple database operations into a single atomic unit, ensuring that both the order and the payment are recorded successfully or neither are recorded.
    *   **Example:**
        ```sql
        BEGIN;
          INSERT INTO Orders (customer_id, order_date, status)
          VALUES (1, CURRENT_DATE, 'Pending') RETURNING order_id;
        
          INSERT INTO Payments (order_id, payment_date, amount, payment_status, payment_method)
          VALUES (1, CURRENT_DATE, 100.00, 'Unpaid', 'card');
        
        COMMIT;
        ```

2.  **Transaction with Repeatable Read Isolation Level:**
    *   **Functionality:** This transaction updates inventory and adds an order item, ensuring consistent inventory levels.
    *   **Use Case:** Demonstrates how to use the `REPEATABLE READ` isolation level to prevent non-repeatable reads, which ensures that data read multiple times within the same transaction remains consistent.
    *    **Example:**
    ```sql
        BEGIN;
          SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
        
          SELECT stock_quantity FROM Inventory WHERE product_id = 1 AND size = 'M';
        
          UPDATE Inventory SET stock_quantity = 9 WHERE product_id = 1 AND size = 'M';
        
          INSERT INTO Order_items (order_id, product_id, quantity, product_price)
          VALUES (1, 1, 1, 100.00);
        
        COMMIT;
    ```

3.  **Transaction with Rollback due to Payment Failure:**
    *   **Functionality:** This transaction adds a new order and simulates a payment failure, rolling back the order insertion.
    *   **Use Case:** Demonstrates how to handle errors within a transaction by rolling back changes when a dependent operation fails, thus ensuring database consistency.
    *    **Example:**
       ```sql
       BEGIN;
          INSERT INTO Orders (customer_id, order_date, status)
          VALUES (1, CURRENT_DATE, 'Pending') RETURNING order_id;
         -- Simulate payment error
         --  INSERT INTO Payments (order_id, payment_date, amount, payment_status, payment_method)
         --  VALUES (1, CURRENT_DATE, 100.00, 'Paid', 'card');
        
          ROLLBACK;
       ```

4.  **Transaction with Serializable Level to Prevent Phantom Reads:**
    *   **Functionality:** This transaction shows how to use the `SERIALIZABLE` isolation level to prevent phantom reads.
    *   **Use Case:** Demonstrates the highest isolation level to prevent phantom reads, ensuring that all operations within the transaction are executed as if they were the only ones running in the system.
    *  **Example:**
      ```sql
      BEGIN;
       SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
        
       SELECT * FROM Inventory;
        
        INSERT INTO Inventory (product_id, size, stock_quantity)
         VALUES (2, 'L', 20);
       COMMIT;
       ```

5.  **Transaction for Adding an Invoice for an Order:**
    *   **Functionality:** This transaction checks if an order has a payment and creates an invoice for that order.
    *   **Use Case:** Shows a multi-step process inside a transaction to maintain consistency between different entities in the database (payment, order, invoice).
     *    **Example:**
    ```sql
        BEGIN;
            -- Step 1: Check if the order has a payment
            SELECT payment_status FROM payments WHERE order_id = 1;
        
            -- Step 2: Create an invoice for the order
            INSERT INTO Invoices (customer_id, order_id, invoice_number, invoice_date, billing_address_id, total_amount, status)
            VALUES (1, 1, 'INV-2023-10-001', CURRENT_DATE, 1, 100.00, 'Pending');
        
        
        COMMIT;
    ```

6. **Transaction for Adding a Customer with Addresses:**
   * **Functionality:** Adds a new customer along with their billing and shipping addresses within a single transaction.
   * **Use Case:** Demonstrates how to insert related data into multiple tables while ensuring all insertions succeed or fail together, thus maintaining data integrity.
     *    **Example:**
       ```sql
      BEGIN;
            -- Step 1: Create Billing Address
            INSERT INTO Addresses (street, city, building_number, flat_number, postal_code, country, type)
            VALUES ('Nowa', 'Warszawa', 10, 2, '00-123', 'Poland', 'house') RETURNING address_id;
        
        
            -- Step 3: Create Shipping Address
            INSERT INTO Addresses (street, city, building_number, flat_number, postal_code, country, type)
            VALUES ('Stara', 'Warszawa', 20, 3, '00-456', 'Poland', 'house') RETURNING address_id;
        
        
        
            -- Step 5: Create a new customer with those addresses
            INSERT INTO Customers (name, surname, email, billing_address_id, shipping_address_id)
            VALUES ('Adam', 'Kowalski', 'adam.kowalski@example.com', 1, 2);
        
        COMMIT;
        ```

7. **Transaction for Handling Opinions:**
   * **Functionality:** Inserts a new opinion and calculates the average rating for the product.
   * **Use Case:** Demonstrates how to perform data manipulation and calculations within a transaction, ensuring that both operations are consistent.
     *    **Example:**
        ```sql
        BEGIN;
            -- Step 1: Add the new opinion
            INSERT INTO Opinions (product_id, customer_id, rating, comment)
            VALUES (1, 1, 5, 'Very good product.');
        
            -- Step 2: Calculate the average rating for the product
            SELECT product_id, AVG(rating) FROM Opinions WHERE product_id = 1 GROUP BY product_id;
        
            
        COMMIT;
        ```

8.  **Transaction for Updating Multiple Order Items and Total Amount:**
     *   **Functionality:** Updates the quantities and prices for multiple order items, demonstrating how to perform multiple updates within a transaction.
     *   **Use Case:** Shows how to use transactions for complex updates that involve multiple records in the same or different tables.
    *  **Example:**
       ```sql
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
        ```

9.  **Transaction for Updating Customer Information and Related Addresses:**
    *   **Functionality:** Updates customer information and related billing and shipping addresses within a single transaction.
    *   **Use Case:** Demonstrates how to update data across multiple tables while ensuring that all changes are made consistently and without race conditions.
    *   **Example:**
       ```sql
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
       ```

10. **Transaction with Savepoints to allow for partial rollbacks:**
   *   **Functionality:**  Uses savepoints to allow partial rollbacks of the transaction
   *   **Use Case:** Demonstrates that you can have finer control over rollbacks using savepoints instead of rollbacking entire transaction.
      *   **Example:**
        ```sql
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
        ```
### Benefits

*   **Data Integrity:** Ensures that related database operations are performed together or not at all.
*   **Consistency:** Prevents inconsistencies by isolating transactions from each other using different isolation levels.
*   **Error Handling:** Allows for the rollback of operations when errors occur, maintaining data correctness.
*  **Flexibility:** Demonstrates different isolation levels and methods to achieve the right balance between data integrity and performance.


These examples serve as a guide on how to structure transactions in your application code, to ensure that data changes are grouped into atomic operations, and are performed correctly using different isolation levels.


