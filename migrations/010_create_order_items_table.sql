CREATE TABLE order_items (
    order_item_id SERIAL PRIMARY KEY,
    order_id INT NOT NULL REFERENCES Orders(order_id),
    product_id INT NOT NULL REFERENCES Products(product_id),
    quantity INT NOT NULL,
    product_price DECIMAL(10, 2) NOT NULL
);

