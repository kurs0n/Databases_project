CREATE TABLE IF NOT EXISTS Inventory (
    inventory_id SERIAL PRIMARY KEY, -- Inventory ID
    product_id INT,                  -- Foreign key to Products table
    size VARCHAR(10) NOT NULL,
    stock_quantity INT DEFAULT 0,    -- Quantity in stock
    last_updated DATE DEFAULT CURRENT_DATE, -- Last updated date
    FOREIGN KEY (product_id) REFERENCES Products(product_id) -- Relating inventory to products
);