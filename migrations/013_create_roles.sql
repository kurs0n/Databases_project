-- Migration file: 004_add_roles_and_permissions.sql

-- This migration file sets up roles and permissions for the database.

-- ------------------------------------------------------------------
-- 1. Create roles
-- ------------------------------------------------------------------

-- Create a role for the administrator
CREATE ROLE admin WITH LOGIN PASSWORD 'admin123' CREATEDB CREATEROLE SUPERUSER;

-- Create a role for the store manager
CREATE ROLE manager WITH LOGIN PASSWORD 'menago';

-- Create a role for a customer
CREATE ROLE customer WITH LOGIN PASSWORD 'customeressa';

-- ------------------------------------------------------------------
-- 2. Grant permissions
-- ------------------------------------------------------------------

-- Default permissions on all tables
GRANT USAGE ON SCHEMA public TO manager, customer;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO manager, customer;

-- --- Administrator permissions
-- Grant all privileges to the admin role, including creating/modifying schemas
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO admin;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO admin;


-- --- Store Manager Permissions
-- Manager can add, update, and delete products and manage orders
GRANT SELECT, INSERT, UPDATE, DELETE ON Products TO manager;
GRANT SELECT, INSERT, UPDATE, DELETE ON Inventory TO manager;
GRANT SELECT, INSERT, UPDATE ON Orders TO manager;
GRANT SELECT, INSERT, UPDATE ON Order_Items TO manager;
GRANT SELECT, INSERT, UPDATE, DELETE ON Invoices TO manager;
GRANT SELECT, INSERT, UPDATE, DELETE ON Payments TO manager;
GRANT SELECT ON Customers TO manager;
GRANT SELECT ON Addresses TO manager;
GRANT SELECT, INSERT, DELETE ON Opinions TO manager;

-- Manager can view information about customers
GRANT SELECT ON Customers TO manager;
GRANT SELECT ON Addresses TO manager;


-- --- Customer Permissions
-- Customer can view products and place orders
GRANT SELECT ON Products TO customer;
GRANT SELECT ON Orders TO customer;
GRANT INSERT ON Orders TO customer;
GRANT SELECT, INSERT ON Order_Items TO customer;
GRANT SELECT ON Invoices TO customer;
GRANT INSERT ON Opinions TO customer;
-- Customer can view and update its own data, which we will need additional logic for in our application
GRANT SELECT ON Customers TO customer;
GRANT SELECT ON Addresses TO customer;
GRANT UPDATE (phone_number) ON Customers TO customer;


-- ------------------------------------------------------------------
-- 3. Set default privileges (for future tables and sequences)
-- ------------------------------------------------------------------

-- Set default privileges for future tables
ALTER DEFAULT PRIVILEGES IN SCHEMA public
  GRANT SELECT ON TABLES TO manager, customer;


-- Set default privileges for future sequences (Corrected part)
ALTER DEFAULT PRIVILEGES IN SCHEMA public
  GRANT USAGE ON SEQUENCES TO manager, customer;



-- Set default privileges for all other new objects for admin
ALTER DEFAULT PRIVILEGES IN SCHEMA public
  GRANT ALL PRIVILEGES ON TABLES TO admin;
ALTER DEFAULT PRIVILEGES IN SCHEMA public
  GRANT ALL PRIVILEGES ON SEQUENCES TO admin;

-- Set default privileges for future tables and sequences for store manager
ALTER DEFAULT PRIVILEGES IN SCHEMA public
  GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO manager;
ALTER DEFAULT PRIVILEGES IN SCHEMA public
  GRANT USAGE ON SEQUENCES TO manager;

-- End of migration file