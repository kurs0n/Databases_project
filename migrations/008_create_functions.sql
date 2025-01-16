CREATE OR REPLACE FUNCTION calculate_average_rating(product_id_input INT)
RETURNS DECIMAL(3, 2) AS $$
DECLARE
 average_rating DECIMAL(3, 2);
BEGIN
 SELECT AVG(rating) INTO average_rating
 FROM Opinions
 WHERE product_id = product_id_input;

 RETURN average_rating;
END;
$$ LANGUAGE plpgsql;


--     SELECT calculate_average_rating(1); -- Replace 1 with the actual product ID

CREATE OR REPLACE FUNCTION calculate_order_total(order_id_input INT)
RETURNS DECIMAL(10, 2) AS $$
DECLARE
    total_amount DECIMAL(10, 2);
BEGIN
   SELECT SUM(quantity*product_price)
    INTO total_amount
    FROM order_items oi
    WHERE order_id = order_id_input;
    RETURN total_amount;
END;
$$ LANGUAGE plpgsql;

--  SELECT calculate_order_total(1); -- Replace 1 with the actual order ID

 CREATE OR REPLACE FUNCTION get_products_by_category(category_name_input VARCHAR)
  RETURNS TABLE (
    product_id INT,
    name VARCHAR(25),
    description TEXT,
    actual_price DECIMAL(10,2)
  ) AS $$
  BEGIN
    RETURN QUERY SELECT
       p.product_id, p.name, p.description, p.actual_price
    FROM Products p
    WHERE p.category = category_name_input;
  END;
  $$ LANGUAGE plpgsql;

-- SELECT * FROM get_products_by_category('Clothing'); -- Replace 'Clothing' with the actual category

CREATE OR REPLACE FUNCTION get_customer_orders(customer_id_input INT)
  RETURNS TABLE (
    order_id INT,
    order_date DATE
  ) AS $$
  BEGIN
   RETURN QUERY SELECT o.order_id, o.order_date FROM Orders o WHERE o.customer_id = customer_id_input;
  END;
  $$ LANGUAGE plpgsql;

-- SELECT * FROM get_customer_orders(1); -- Replace 1 with the actual customer ID

 CREATE OR REPLACE FUNCTION get_invoice_details(invoice_id_input INT)
 RETURNS TABLE (
     invoice_id INT,
     invoice_number VARCHAR(50),
     invoice_date DATE,
     due_date DATE,
     total_amount DECIMAL(10, 2),
     tax_amount DECIMAL(10, 2),
     discount_amount DECIMAL(10, 2),
     invoice_status VARCHAR(10),
     customer_name VARCHAR(25),
     customer_surname VARCHAR(25),
     customer_email VARCHAR(50),
     billing_address TEXT,
     shipping_address TEXT
  ) AS $$
  BEGIN
    RETURN QUERY SELECT
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
         c.email AS customer_email,
         (a1.street || ', ' || a1.building_number ||
             CASE WHEN a1.flat_number IS NOT NULL THEN '/' || a1.flat_number ELSE '' END || ', ' ||
             a1.city || ', ' || a1.postal_code || ', ' || a1.country) AS billing_address,
         (a2.street || ', ' || a2.building_number ||
             CASE WHEN a2.flat_number IS NOT NULL THEN '/' || a2.flat_number ELSE '' END || ', ' ||
             a2.city || ', ' || a2.postal_code || ', ' || a2.country) AS shipping_address
         FROM
         Invoices i
         JOIN Customers c ON i.customer_id = c.customer_id
         JOIN Addresses a1 ON i.billing_address_id = a1.address_id
         LEFT JOIN Addresses a2 ON i.shipping_address_id = a2.address_id
         WHERE i.invoice_id = invoice_id_input;
  END;
  $$ LANGUAGE plpgsql;

-- SELECT * FROM get_invoice_details(1); -- Replace 1 with the actual invoice ID