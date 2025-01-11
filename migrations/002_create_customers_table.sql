CREATE TABLE IF NOT EXISTS Addresses (
    address_id SERIAL PRIMARY KEY,
    street VARCHAR(50),
    city VARCHAR(50) NOT NULL,
    building_number INT NOT NULL,
    flat_number INT,
    postal_code VARCHAR(10) NOT NULL,
    country VARCHAR(50) NOT NULL, 
    description VARCHAR(50),
    type VARCHAR(20) CHECK (type IN ('house', 'parcel locker', 'shop')) NOT NULL
);

CREATE TABLE IF NOT EXISTS Customers (
    customer_id SERIAL PRIMARY KEY,
    name VARCHAR(25) NOT NULL,
    surname VARCHAR(25) NOT NULL,
    email VARCHAR(50) UNIQUE NOT NULL,
    phone_number VARCHAR(15),
    shipping_address_id INT,
    billing_address_id INT,
    FOREIGN KEY (shipping_address_id) REFERENCES Addresses(address_id),
    FOREIGN KEY (billing_address_id) REFERENCES Addresses(address_id)
);
