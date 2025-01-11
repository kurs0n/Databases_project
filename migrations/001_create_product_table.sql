CREATE TABLE IF NOT EXISTS Products (
    product_id SERIAL PRIMARY KEY,   -- Product ID is the primary key
    name VARCHAR(25) NOT NULL,                           -- Product name
    description TEXT,                                     -- Product description
    regular_price DECIMAL(10, 2) NOT NULL,                -- Regular price of the product
    actual_price DECIMAL(10, 2) NOT NULL,                 -- Actual price of the product
    category VARCHAR(50),                                 -- Product category
    lowest_price_30 DECIMAL(10, 2) NOT NULL,              -- The lowest price of the product
    size VARCHAR(10) NOT NULL,                            -- Product size 
    color VARCHAR(10) NOT NULL,                           -- Product color
    sex VARCHAR(10) NOT NULL CHECK (sex IN ('Male', 'Female', 'Unisex')) -- Product sex
);
