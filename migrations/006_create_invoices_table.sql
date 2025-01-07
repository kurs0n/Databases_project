CREATE TABLE IF NOT EXISTS Invoices (
    invoice_id SERIAL PRIMARY KEY,
    customer_id INT NOT NULL,
    order_id INT,
    invoice_number VARCHAR(50) UNIQUE NOT NULL,
    invoice_date DATE NOT NULL,
    due_date DATE,
    billing_address_id INT NOT NULL,
    shipping_address_id INT,
    total_amount DECIMAL(10, 2) NOT NULL,
    tax_amount DECIMAL(10, 2) DEFAULT 23.00,
    discount_amount DECIMAL(10, 2) DEFAULT 0.00,
    status VARCHAR(10) CHECK (status IN ('Pending', 'Paid', 'Overdue', 'Cancelled')) NOT NULL DEFAULT 'Pending',
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (billing_address_id) REFERENCES Addresses(address_id),
    FOREIGN KEY (shipping_address_id) REFERENCES Addresses(address_id),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
   NEW.updated_at = NOW();
   RETURN NEW;
END;
$$ language 'plpgsql';

CREATE TRIGGER update_invoices_updated_at
BEFORE UPDATE ON Invoices
FOR EACH ROW
EXECUTE FUNCTION update_updated_at_column();
