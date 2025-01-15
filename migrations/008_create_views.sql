CREATE VIEW view_orders_customers AS
SELECT 
    o.order_id,
    o.order_date,
    o.status AS order_status,
    c.name AS customer_name,
    c.surname AS customer_surname,
    c.email AS customer_email
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id;

CREATE VIEW view_invoices AS
SELECT 
    i.invoice_id,
    i.invoice_number,
    i.invoice_date,
    i.due_date,
    i.total_amount,
    i.tax_amount,
    i.discount_amount,
    i.status AS invoice_status,
    c.name AS customer_name,
    c.surname AS customer_surname,
    o.order_date AS order_date
FROM Invoices i
JOIN Customers c ON i.customer_id = c.customer_id
LEFT JOIN Orders o ON i.order_id = o.order_id;

CREATE VIEW view_products_inventory AS
SELECT 
    p.product_id,
    p.name AS product_name,
    p.description,
    p.actual_price,
    p.category,
    i.size,
    i.stock_quantity,
    i.last_updated
FROM Products p
JOIN Inventory i ON p.product_id = i.product_id;