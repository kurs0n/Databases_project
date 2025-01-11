INSERT INTO Products (name, description, regular_price, actual_price, category, lowest_price_30, size, color, sex) 
VALUES 
('T-Shirt', 'Cotton T-shirt with a round neck', 20.00, 18.00, 'Clothing', 17.00, 'M', 'Red', 'Unisex'),
('Jeans', 'Slim-fit blue jeans', 50.00, 45.00, 'Clothing', 42.00, 'L', 'Blue', 'Male'),
('Sneakers', 'White sports sneakers', 70.00, 65.00, 'Footwear', 60.00, '42', 'White', 'Unisex');

INSERT INTO Addresses (street, city, building_number, flat_number, postal_code, country, description, type) 
VALUES 
('Main Street', 'New York', 123, NULL, '10001', 'USA', 'Billing address', 'house'),
('Elm Street', 'Chicago', 45, 12, '60614', 'USA', 'Shipping address', 'shop'),
('Market Street', 'Los Angeles', 78, NULL, '90001', 'USA', 'Parcel locker at the mall', 'parcel locker');

INSERT INTO Customers (name, surname, email, phone_number, shipping_address_id, billing_address_id) 
VALUES 
('John', 'Doe', 'john.doe@example.com', '123456789', 2, 1),
('Jane', 'Smith', 'jane.smith@example.com', '987654321', 3, 1);

INSERT INTO Orders (customer_id, order_date, status) 
VALUES 
(1, '2025-01-10', 'Pending'),
(2, '2025-01-09', 'Completed');

INSERT INTO Payments (order_id, payment_date, amount, payment_status, payment_method) 
VALUES 
(1, '2025-01-11', 18.00, 'Paid', 'card'),
(2, '2025-01-10', 45.00, 'Paid', 'paypal');

INSERT INTO Inventory (product_id, size, stock_quantity, last_updated) 
VALUES 
(1, 'M', 100, '2025-01-10'),
(2, 'L', 50, '2025-01-09'),
(3, '42', 30, '2025-01-11');

INSERT INTO Opinions (product_id, customer_id, rating, comment) 
VALUES 
(1, 1, 5, 'Great quality T-shirt, very comfortable!'),
(2, 2, 4, 'The jeans fit well, but the color was slightly different than expected.'),
(3, 1, 5, 'Love these sneakers, they are very comfortable for running.');

INSERT INTO Invoices (customer_id, order_id, invoice_number, invoice_date, due_date, billing_address_id, shipping_address_id, total_amount, tax_amount, discount_amount, status, notes) 
VALUES 
(1, 1, 'INV-2025-001', '2025-01-10', '2025-01-20', 1, 2, 20.00, 3.00, 2.00, 'Paid', 'Paid via card.'),
(2, 2, 'INV-2025-002', '2025-01-09', '2025-01-19', 1, 3, 50.00, 5.00, 0.00, 'Paid', 'Paid via PayPal.');

ALTER TABLE Opinions
ADD CONSTRAINT unique_product_customer_opinion UNIQUE (product_id, customer_id);
