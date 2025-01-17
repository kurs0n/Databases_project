## Database Roles and Permissions Setup

This section outlines the roles and permissions configured for the database using the `013_create_roles.sql` migration file.

### 1. Roles

This migration creates three distinct roles with varying levels of access:

*   **`admin`**: 
    *   The administrator role with full access.
    *   Has the ability to login, create databases, create other roles and is a superuser.
    *   Has full control over all database objects and can perform all operations.
*   **`manager`**:
    *   The store manager role, intended for staff members managing products and orders.
    *   Has the ability to log in and perform specific actions related to managing the store's data.
*   **`customer`**:
    *   The customer role, intended for users placing orders and providing feedback.
    *   Has the ability to log in and access the database with limited permissions.

### 2. Permissions

The following permissions are granted to each role:

*   **Default Permissions:**
    *   All `manager` and `customer` roles have `USAGE` on the `public` schema.
    *   `manager` and `customer` roles have `SELECT` access on all tables by default.
*   **`admin` Role Permissions:**
    *   Has `ALL PRIVILEGES` on all tables within the `public` schema.
    *   Has `ALL PRIVILEGES` on all sequences within the `public` schema.
    *   This role has the highest level of access, allowing them to perform any action.
*   **`manager` Role Permissions:**
    *   `SELECT, INSERT, UPDATE, DELETE` on `Products`, `Inventory`, `Orders`, `Order_Items`, `Invoices`, `Payments`, and `Opinions` tables.
    *   `SELECT` on the `Customers` and `Addresses` tables, providing visibility into customer details and addresses.
    *   Allows the manager to fully control products, orders, and related information.
*   **`customer` Role Permissions:**
    *   `SELECT` on `Products`, `Orders`, and `Invoices` tables.
    *   `INSERT` on `Orders`, `Order_Items`, and `Opinions` tables.
    *   `SELECT` on `Customers`, `Addresses` tables.
    *   `UPDATE` on the `Customers` table, but only for the `phone_number` column, allowing them to update their own contact information.
    *   Allows customers to view products, place orders, provide feedback and manage limited parts of their profiles.

### 3. Default Privileges

Default privileges are configured for future tables and sequences, ensuring that newly created objects automatically inherit the correct permissions:

*   **For Tables:**
    *   `manager` and `customer` roles are granted `SELECT` on future tables created in the public schema.
    *   The `manager` role is granted `SELECT, INSERT, UPDATE, DELETE` on future tables created in the public schema.
*   **For Sequences:**
    *   `manager` and `customer` roles are granted `USAGE` on future sequences created in the public schema.
    *   The `manager` role is granted `USAGE` on future sequences.

*   **For All New objects**
     *  The `admin` role is granted `ALL PRIVILEGES` on tables and sequences created in the `public` schema

### Important Notes

*   **Passwords:** The passwords used in this migration file are simple placeholders for demonstration purposes. It is crucial to use strong, secure passwords and manage them appropriately in a production environment.
*   **Application logic:** Application code should still implement additional authorization checks to make sure users have the correct permissions.
*   **Role-based access:** These roles allow you to implement Role-Based Access Control (RBAC) in your application.
*  **Secure by default:** The default privileges are set to ensure new tables and sequences inherit the correct permissions, making them secure from the start.