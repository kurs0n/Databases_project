CREATE TABLE IF NOT EXISTS Opinions (
    opinion_id SERIAL PRIMARY KEY,   -- Opinion ID is the primary key
    product_id INT NOT NULL,         -- Foreign key to the Products table
    customer_id INT NOT NULL,        -- ID of the user who gave the opinion
    rating INT NOT NULL CHECK (rating >= 1 AND rating <= 5), -- Rating given by the user
    comment TEXT,                    -- Comment given by the user
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Timestamp of when the opinion was created
    FOREIGN KEY (product_id) REFERENCES Products(product_id), -- Foreign key constraint
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);