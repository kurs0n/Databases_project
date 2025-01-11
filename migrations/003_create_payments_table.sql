CREATE TABLE Orders (
    order_id SERIAL PRIMARY KEY,     -- Order ID
    customer_id INT,                                      -- Foreign key to Customers table
    order_date DATE NOT NULL,                             -- Order date
    status VARCHAR(20) CHECK (status IN ('Pending', 'Completed', 'Cancelled')) DEFAULT 'Pending', -- Order status
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id) -- Relating orders to customers
); 

CREATE TABLE IF NOT EXISTS Payments (
    payment_id SERIAL PRIMARY KEY,   -- Payment ID
    order_id INT,                                         -- Foreign key to Orders table
    payment_date DATE NOT NULL,                           -- Payment date
    amount DECIMAL(10, 2) NOT NULL,                       -- Payment amount
    payment_status VARCHAR(10) CHECK (payment_status IN ('Paid', 'Unpaid')) DEFAULT 'Unpaid', -- Payment status
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),    -- Relating payments to orders
    payment_method VARCHAR(10) CHECK (payment_method IN ('blik', 'card', 'paypal', 'sms', 'voucher')) NOT NULL -- Type of payment
);