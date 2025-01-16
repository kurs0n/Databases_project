-- Inserting data into Addresses table

INSERT INTO Addresses (street, city, building_number, flat_number, postal_code, country, description, type)
VALUES
    ('Main Street', 'New York', 123, NULL, '10001', 'USA', 'Primary residence', 'house'),
    ('Park Avenue', 'Los Angeles', 456, 10, '90001', 'USA', 'Apartment building', 'house'),
    ('Market Square', 'London', 789, NULL, 'SW1A 0AA', 'UK', 'Office location', 'shop'),
    ('High Road', 'Paris', 101, 5, '75001', 'France', 'Parcel locker', 'parcel locker'),
    ('Wall Street', 'Tokyo', 202, NULL, '100-0001', 'Japan', 'Secondary residence', 'house'),
    (NULL, 'Warsaw', 12, 10, '00-001', 'Poland', 'Summer apartment', 'house'),
     (NULL, 'Berlin', 14, NULL, '10115', 'Germany', 'Parcel locker', 'parcel locker'),
      (NULL, 'Rome', 13, NULL, '00100', 'Italy', 'Shop', 'shop');


-- Inserting data into Customers table

INSERT INTO Customers (name, surname, email, phone_number, shipping_address_id, billing_address_id)
VALUES
    ('John', 'Doe', 'john.doe@example.com', '555-1234', 1, 1),
    ('Jane', 'Smith', 'jane.smith@example.com', '555-5678', 2, 2),
    ('Alice', 'Brown', 'alice.brown@example.com', NULL, 3, 3),
    ('Bob', 'Jones', 'bob.jones@example.com', '555-9012', 4, 4),
    ('Eve', 'White', 'eve.white@example.com', '555-3456', 5, 5),
    ('Katarzyna', 'Nowak', 'kasia.nowak@example.com', '123-456-789', 6, 6),
    ('Max', 'Mustermann', 'max.mustermann@example.com', NULL, 7, 7),
    ('Sofia', 'Rossi', 'sofia.rossi@example.com', '123-123-123', 8, 8);


-- Inserting data into Products table

INSERT INTO Products (name, description, regular_price, actual_price, category, lowest_price_30, size, color, sex)
VALUES
    ('T-shirt', 'Comfortable cotton t-shirt', 25.00, 20.00, 'Clothing', 20.00, 'M', 'Blue', 'Male'),
    ('Jeans', 'Classic denim jeans', 70.00, 60.00, 'Clothing', 60.00, '32', 'Black', 'Male'),
    ('Dress', 'Elegant summer dress', 90.00, 80.00, 'Clothing', 80.00, 'S', 'Red', 'Female'),
    ('Sneakers', 'Sport running shoes', 120.00, 100.00, 'Shoes', 100.00, '10', 'White', 'Unisex'),
    ('Shirt', 'Classic white shirt', 60.00, 50.00, 'Clothing', 50.00, 'L', 'White', 'Male'),
    ('Hoodie', 'Warm winter hoodie', 80.00, 70.00, 'Clothing', 70.00, 'M', 'Gray', 'Unisex'),
    ('Skirt', 'Pleated summer skirt', 70.00, 65.00, 'Clothing', 65.00, 'M', 'Pink', 'Female'),
    ('Boots', 'Winter boots with fur', 150.00, 130.00, 'Shoes', 130.00, '9', 'Brown', 'Female');

-- Inserting data into Orders table
INSERT INTO Orders (customer_id, order_date, status)
VALUES
    (1, '2024-01-15', 'Completed'),
    (2, '2024-02-20', 'Pending'),
    (3, '2024-03-01', 'Cancelled'),
    (1, '2024-04-10', 'Completed'),
    (4, '2024-05-05', 'Pending'),
    (2, '2024-06-12', 'Completed'),
    (5, '2024-07-07', 'Pending'),
    (3, '2024-08-01', 'Cancelled');

-- Inserting data into Payments table
INSERT INTO Payments (order_id, payment_date, amount, payment_status, payment_method)
VALUES
    (1, '2024-01-16', 20.00, 'Paid', 'card'),
    (2, '2024-02-21', 60.00, 'Unpaid', 'blik'),
    (3, '2024-03-02', 80.00, 'Unpaid', 'voucher'),
    (4, '2024-04-11', 100.00, 'Paid', 'card'),
    (5, '2024-05-06', 50.00, 'Unpaid', 'sms'),
    (6, '2024-06-13', 65.00, 'Paid', 'paypal'),
    (7, '2024-07-08', 70.00, 'Unpaid', 'blik'),
    (8, '2024-08-02', 130.00, 'Paid', 'card');

-- Inserting data into Inventory table

INSERT INTO Inventory (product_id, size, stock_quantity, last_updated)
VALUES
    (1, 'M', 50, '2024-08-10'),
    (2, '32', 20, '2024-08-10'),
    (3, 'S', 30, '2024-08-10'),
    (4, '10', 40, '2024-08-10'),
     (5, 'L', 10, '2024-08-10'),
      (6, 'M', 25, '2024-08-10'),
    (7, 'M', 15, '2024-08-10'),
    (8, '9', 5, '2024-08-10');

-- Inserting data into Opinions table
INSERT INTO Opinions (product_id, customer_id, rating, comment, created_at)
VALUES
    (1, 1, 4, 'Great t-shirt!', '2024-08-05 10:00:00'),
    (2, 2, 5, 'Perfect fit!', '2024-08-06 12:30:00'),
    (3, 3, 3, 'Nice dress, but a bit too large.', '2024-08-07 14:45:00'),
    (1, 4, 5, 'Good quality!', '2024-08-08 16:00:00'),
    (4, 5, 2, 'Not comfortable at all.', '2024-08-09 11:15:00'),
    (5, 6, 4, 'Good basic shirt.', '2024-08-10 13:00:00'),
    (6, 7, 5, 'Great hoodie!', '2024-08-11 15:00:00'),
      (7, 8, 3, 'Pleated skirt is ok.', '2024-08-12 16:30:00');

-- Inserting data into Invoices table
INSERT INTO Invoices (customer_id, order_id, invoice_number, invoice_date, due_date, billing_address_id, shipping_address_id, total_amount, tax_amount, discount_amount, status, notes)
VALUES
    (1, 1, 'INV20240115-001', '2024-01-15', '2024-01-30', 1, 1, 20.00, 4.60, 0.00, 'Paid', 'Payment received.'),
    (2, 2, 'INV20240220-002', '2024-02-20', '2024-03-06', 2, 2, 60.00, 13.80, 0.00, 'Pending', 'Payment expected soon.'),
    (3, NULL, 'INV20240301-003', '2024-03-01', NULL, 3, NULL, 80.00, 18.40, 0.00, 'Cancelled', 'Order cancelled.'),
    (1, 4, 'INV20240410-004', '2024-04-10', '2024-04-25', 1, 1, 100.00, 23.00, 10.00, 'Paid', 'Discount applied.'),
    (4, 5, 'INV20240505-005', '2024-05-05', '2024-05-20', 4, 4, 50.00, 11.50, 0.00, 'Overdue', 'Payment overdue!'),
    (2, 6, 'INV20240612-006', '2024-06-12', '2024-06-27', 2, 2, 65.00, 14.95, 5.00, 'Paid', 'Payment received.'),
    (5, 7, 'INV20240707-007', '2024-07-07', NULL, 5, 5, 70.00, 16.10, 0.00, 'Pending', 'Payment expected.'),
    (3, 8, 'INV20240801-008', '2024-08-01', NULL, 3, 3, 130.00, 29.90, 0.00, 'Cancelled', 'Payment cancelled.');