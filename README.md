# Databases_project

## How-To-Run

make sure that You have docker 

1. `make run_container`
2. `make migrate_files`


## workflow

add migration files like that:

if the last element is 002 -> You should add to migration folder 003_[what You have done] 

create pr!


## Wymagania ogólne:

Każdy zespół tworzy i realizuje własny projekt bazodanowy, obejmujący pełny cykl życia systemu: od analizy wymagań, przez projektowanie i implementację schematu bazy, aż po testowanie i dokumentację techniczną.
Możecie pracować w dowolnym systemie zarządzania bazą danych (np. PostgreSQL, MariaDB, MySQL, Oracle, SQL Server – wybór zależy od Waszych preferencji i doświadczenia).
Każdy członek zespołu jest odpowiedzialny za wybrany obszar prac (np. analiza wymagań, projekt logiczny i fizyczny, implementacja funkcji, optymalizacja zapytań, dokumentacja).
Ocenie podlega zarówno współpraca zespołowa, jak i indywidualny wkład.


* Poprawnie działające podstawowe funkcjonalności bazy danych
* Schemat bazy zgodny z podstawowymi zasadami normalizacji (2NF)
* Prosta dokumentacja (użytkowa i techniczna)
* Rozbudowana funkcjonalność, w tym zaawansowane zapytania SQL (np. zapytania zagnieżdżone, widoki)
* Zastosowanie wyzwalaczy lub procedur/funkcji w języku proceduralnym właściwym dla wybranego SGBD
* Dobrze przygotowana dokumentacja techniczna z diagramami ERD i opisem implementacji
* Struktura bazy danych zgodna z 3NF
* Wykorzystanie mechanizmów transakcyjnych i różnych poziomów izolacji
* Uwzględnienie bezpieczeństwa danych (role, uprawnienia)
* Prezentacja projektu (prezentacja obowiązkowa dla oceny 4,5 i wyższej)
* Kompletny projekt obejmujący pełny cykl życia bazy danych
* Optymalizacja wydajności poprzez indeksowanie i analizę zapytań (np. użycie narzędzi typu EXPLAIN)
* Wysokiej jakości dokumentacja, obejmująca m.in. szczegóły implementacji i studium przypadku użytkownika
* Prezentacja projektu (obowiązkowa dla uzyskania oceny 5,0)

# Dokumentacja

## Database structure

### **Table: Products**

| Field Name         | Data Type         | Length | Description                                                                 |
|--------------------|-------------------|--------|-----------------------------------------------------------------------------|
| `product_id`       | `SERIAL`          | -      | Unique identifier for each product.                                         |
| `name`             | `VARCHAR`         | 25     | The name of the product (required).                                         |
| `description`      | `TEXT`            | -      | A detailed description of the product (optional).                           |
| `regular_price`    | `DECIMAL(10, 2)`  | -      | The regular price of the product, with up to 10 digits and 2 decimal places.|
| `actual_price`     | `DECIMAL(10, 2)`  | -      | The actual (current) price of the product, with up to 10 digits and 2 decimal places.|
| `category`         | `VARCHAR`         | 50     | The category to which the product belongs (optional).                       |
| `lowest_price_30`  | `DECIMAL(10, 2)`  | -      | The lowest price of the product in the last 30 days.                        |
| `size`             | `VARCHAR`         | 10     | The size of the product (e.g., S, M, L).                                    |
| `color`            | `VARCHAR`         | 10     | The color of the product (e.g., red, blue).                                 |
| `sex`              | `VARCHAR`         | 10     | The gender category of the product (`Male`, `Female`, or `Unisex`).         |

 **Notes**:
- **Primary Key**: The `product_id` column uniquely identifies each product in the table.
- **Mandatory Fields**: The `name`, `regular_price`, `actual_price`, `size`, `color`, and `sex` columns must have values (`NOT NULL` constraint).
- **Default Values**: The `lowest_price_30` column must always have a value (no default), and prices must be manually specified.
- **Precision in Prices**: Both `regular_price` and `actual_price` columns support up to 10 total digits with 2 digits after the decimal point (e.g., `99999999.99`).
- **Constraints**: The `sex` column is restricted to one of the following values: `Male`, `Female`, or `Unisex` using a `CHECK` constraint.

---

### **Table: Addresses**

| Field Name        | Data Type        | Length | Description                                                              |
|-------------------|------------------|--------|--------------------------------------------------------------------------|
| `address_id`      | `SERIAL`         | -      | Unique identifier for each address.                                      |
| `street`          | `VARCHAR`        | 50     | The name of the street (optional).                                       |
| `city`            | `VARCHAR`        | 50     | The name of the city (required).                                         |
| `building_number` | `INT`            | -      | The building number (required).                                          |
| `flat_number`     | `INT`            | -      | The flat or apartment number (optional).                                 |
| `postal_code`     | `VARCHAR`        | 10     | The postal code (required).                                              |
| `country`         | `VARCHAR`        | 50     | The country where the address is located (required).                     |
| `description`     | `VARCHAR`        | 50     | Additional description of the address (optional).                        |
| `type`            | `VARCHAR`        | 20     | The type of address (`house`, `parcel locker`, or `shop`) (required).    |

**Notes:**
- **Primary Key**: The `address_id` column uniquely identifies each address in the table.
- **Mandatory Fields**: The `city`, `building_number`, `postal_code`, `country`, and `type` columns must have values (`NOT NULL` constraint).
- **Optional Fields**: The `street`, `flat_number`, and `description` columns are optional and can be left empty.
- **Constraints**: The `type` column can only contain one of the following values: `house`, `parcel locker`, or `shop` using a `CHECK` constraint.
- **Length Restrictions**: The `street`, `city`, and `country` columns can hold up to 50 characters, and the `postal_code` column can hold up to 10 characters.

---

### **Table: Customers**

| Field Name           | Data Type        | Length | Description                                                           |
|----------------------|------------------|--------|-----------------------------------------------------------------------|
| `customer_id`        | `SERIAL`         | -      | Unique identifier for each customer.                                  |
| `name`               | `VARCHAR`        | 25     | The first name of the customer (required).                            |
| `surname`            | `VARCHAR`        | 25     | The surname of the customer (required).                               |
| `email`              | `VARCHAR`        | 50     | The unique email address of the customer (required).                  |
| `phone_number`       | `VARCHAR`        | 15     | The phone number of the customer (optional).                          |
| `shipping_address_id`| `INT`            | -      | Foreign key referencing the shipping address in the `Addresses` table.|
| `billing_address_id` | `INT`            | -      | Foreign key referencing the billing address in the `Addresses` table. |

**Notes:**
- **Primary Key**: The `customer_id` column uniquely identifies each customer in the table.
- **Mandatory Fields**: The `name`, `surname`, and `email` columns must have values (`NOT NULL` constraint).
- **Unique Constraint**: The `email` column must contain unique values, ensuring no two customers can have the same email address.
- **Optional Fields**: The `phone_number`, `shipping_address_id`, and `billing_address_id` columns are optional and can be left empty.
- **Foreign Keys**: 
  - `shipping_address_id` references `address_id` in the `Addresses` table to associate a customer with a shipping address.
  - `billing_address_id` references `address_id` in the `Addresses` table to associate a customer with a billing address.
- **Length Restrictions**: The `name` and `surname` columns can hold up to 25 characters, and the `email` column can hold up to 50 characters.

---

### **Table: Orders**

| Field Name    | Data Type        | Length | Description                                                                 |
|---------------|------------------|--------|-----------------------------------------------------------------------------|
| `order_id`    | `SERIAL`         | -      | Unique identifier for each order.                                           |
| `customer_id` | `INT`            | -      | Foreign key referencing the customer who placed the order in the `Customers` table. |
| `order_date`  | `DATE`           | -      | The date when the order was placed (required).                              |
| `status`      | `VARCHAR`        | 20     | The status of the order (`Pending`, `Completed`, or `Cancelled`) (required, with default `Pending`). |

**Notes:**
- **Primary Key**: The `order_id` column uniquely identifies each order in the table.
- **Mandatory Fields**: The `order_date` and `status` columns must have values (`NOT NULL` constraint on `order_date`).
- **Default Values**: The `status` column defaults to `Pending` if no value is specified.
- **Constraints**: The `status` column can only contain one of the following values: `Pending`, `Completed`, or `Cancelled` using a `CHECK` constraint.
- **Foreign Key**: 
  - `customer_id` references `customer_id` in the `Customers` table, establishing a relationship between orders and customers.

---

### **Table: Order Items**

| Field Name        | Data Type         | Length | Description                                                          |
|-------------------|-------------------|--------|----------------------------------------------------------------------|
| `order_item_id`   | `SERIAL`          | -      | Unique identifier for each item in the order.                        |
| `order_id`        | `INT`             | -      | Foreign key referencing the order in the `Orders` table.             |
| `product_id`      | `INT`             | -      | Foreign key referencing the product in the `Products` table.         |
| `quantity`        | `INT`             | -      | The quantity of the product ordered (required).                      |
| `product_price`   | `DECIMAL(10, 2)`  | -      | The price of the product at the time of the order (required).         |

---

### **Notes**:
- **Primary Key**: The `order_item_id` column uniquely identifies each record in the table.
- **Mandatory Fields**: The `order_id`, `product_id`, `quantity`, and `product_price` columns must have values (`NOT NULL` constraint).
- **Foreign Keys**:
  - `order_id` references `order_id` in the `Orders` table, establishing a relationship between the order and its items.
  - `product_id` references `product_id` in the `Products` table, linking the item to a specific product.

---

### **Table: Payments**

| Field Name       | Data Type         | Length | Description                                                                 |
|------------------|-------------------|--------|-----------------------------------------------------------------------------|
| `payment_id`     | `SERIAL`          | -      | Unique identifier for each payment.                                         |
| `order_id`       | `INT`             | -      | Foreign key referencing the related order in the `Orders` table.            |
| `payment_date`   | `DATE`            | -      | The date when the payment was made (required).                              |
| `amount`         | `DECIMAL(10, 2)`  | -      | The amount paid, with up to 10 digits and 2 decimal places (required).      |
| `payment_status` | `VARCHAR`         | 10     | The status of the payment (`Paid` or `Unpaid`) (default is `Unpaid`).       |
| `payment_method` | `VARCHAR`         | 10     | The method of payment (`blik`, `card`, `paypal`, `sms`, or `voucher`) (required). |

**Notes:**
- **Primary Key**: The `payment_id` column uniquely identifies each payment in the table.
- **Mandatory Fields**: The `payment_date`, `amount`, `payment_status`, and `payment_method` columns must have values (`NOT NULL` constraint).
- **Default Values**: The `payment_status` column defaults to `Unpaid` if no value is provided.
- **Constraints**: 
  - The `payment_status` column can only contain the values `Paid` or `Unpaid` using a `CHECK` constraint.
  - The `payment_method` column can only contain one of the following values: `blik`, `card`, `paypal`, `sms`, or `voucher`.
- **Foreign Key**: 
  - `order_id` references `order_id` in the `Orders` table, ensuring that each payment is associated with a valid order.

---

### **Table: Inventory**

| Field Name       | Data Type        | Length | Description                                                               |
|------------------|------------------|--------|---------------------------------------------------------------------------|
| `inventory_id`   | `SERIAL`         | -      | Unique identifier for each inventory record.                              |
| `product_id`     | `INT`            | -      | Foreign key referencing the product in the `Products` table.              |
| `size`           | `VARCHAR`        | 10     | The size of the product (required).                                       |
| `stock_quantity` | `INT`            | -      | The quantity of the product in stock (defaults to 0 if not specified).    |
| `last_updated`   | `DATE`           | -      | The date when the inventory was last updated (defaults to current date).  |

**Notes:**
- **Primary Key**: The `inventory_id` column uniquely identifies each inventory record in the table.
- **Mandatory Fields**: The `size` column must have a value (`NOT NULL` constraint).
- **Default Values**: 
  - The `stock_quantity` column defaults to `0` if no value is provided.
  - The `last_updated` column defaults to the current date if no value is provided.
- **Foreign Key**: 
  - `product_id` references `product_id` in the `Products` table, establishing a relationship between inventory records and products.

---

### **Table: Opinions**

| Field Name    | Data Type         | Length | Description                                                               |
|---------------|-------------------|--------|---------------------------------------------------------------------------|
| `opinion_id`  | `SERIAL`          | -      | Unique identifier for each opinion.                                       |
| `product_id`  | `INT`             | -      | Foreign key referencing the product in the `Products` table (required).   |
| `customer_id` | `INT`             | -      | Foreign key referencing the customer in the `Customers` table (required). |
| `rating`      | `INT`             | -      | The rating given by the customer (required, must be between 1 and 5).     |
| `comment`     | `TEXT`            | -      | The comment provided by the customer (optional).                          |
| `created_at`  | `TIMESTAMP`       | -      | The timestamp when the opinion was created (defaults to current timestamp).|

**Notes:**
- **Primary Key**: The `opinion_id` column uniquely identifies each opinion in the table.
- **Mandatory Fields**: The `product_id`, `customer_id`, and `rating` columns must have values (`NOT NULL` constraint).
- **Default Values**: The `created_at` column defaults to the current timestamp if no value is provided.
- **Constraints**: 
  - The `rating` column must be an integer between 1 and 5, enforced by a `CHECK` constraint.
- **Foreign Keys**: 
  - `product_id` references `product_id` in the `Products` table, ensuring that each opinion is associated with a valid product.
  - `customer_id` references `customer_id` in the `Customers` table, ensuring that each opinion is associated with a valid customer.

---

### **Table: Invoices**

| Field Name           | Data Type        | Length | Description                                                                 |
|----------------------|------------------|--------|-----------------------------------------------------------------------------|
| `invoice_id`         | `SERIAL`         | -      | Unique identifier for each invoice.                                         |
| `customer_id`        | `INT`            | -      | Foreign key referencing the customer in the `Customers` table (required).   |
| `order_id`           | `INT`            | -      | Foreign key referencing the order in the `Orders` table (optional).         |
| `invoice_number`     | `VARCHAR`        | 50     | Unique number assigned to the invoice (required).                           |
| `invoice_date`       | `DATE`           | -      | The date when the invoice was created (required).                           |
| `due_date`           | `DATE`           | -      | The date by which the payment is due (optional).                            |
| `billing_address_id` | `INT`            | -      | Foreign key referencing the billing address in the `Addresses` table (required). |
| `shipping_address_id`| `INT`            | -      | Foreign key referencing the shipping address in the `Addresses` table (optional).|
| `total_amount`       | `DECIMAL(10, 2)` | -      | The total amount for the invoice (required).                                |
| `tax_amount`         | `DECIMAL(10, 2)` | -      | The tax amount applied to the invoice (defaults to 23.00).                  |
| `discount_amount`    | `DECIMAL(10, 2)` | -      | The discount amount applied to the invoice (defaults to 0.00).              |
| `status`             | `VARCHAR`        | 10     | The status of the invoice (`Pending`, `Paid`, `Overdue`, or `Cancelled`) (required, defaults to `Pending`). |
| `notes`              | `TEXT`           | -      | Additional notes related to the invoice (optional).                         |
| `created_at`         | `TIMESTAMP`      | -      | The timestamp when the invoice was created (defaults to current timestamp). |
| `updated_at`         | `TIMESTAMP`      | -      | The timestamp when the invoice was last updated (defaults to current timestamp). |

**Notes:**
- **Primary Key**: The `invoice_id` column uniquely identifies each invoice in the table.
- **Mandatory Fields**: The `customer_id`, `invoice_number`, `invoice_date`, `billing_address_id`, `total_amount`, and `status` columns must have values (`NOT NULL` constraint).
- **Default Values**: 
  - The `tax_amount` column defaults to `23.00` if no value is specified.
  - The `discount_amount` column defaults to `0.00` if no value is specified.
  - The `status` column defaults to `Pending` if no value is specified.
  - The `created_at` and `updated_at` columns default to the current timestamp.
- **Constraints**: 
  - The `status` column can only contain one of the following values: `Pending`, `Paid`, `Overdue`, or `Cancelled` using a `CHECK` constraint.
  - The `invoice_number` column must contain unique values, ensuring no two invoices have the same number.
- **Foreign Keys**:
  - `customer_id` references `customer_id` in the `Customers` table, associating the invoice with a customer.
  - `order_id` references `order_id` in the `Orders` table, linking the invoice to a specific order.
  - `billing_address_id` and `shipping_address_id` reference `address_id` in the `Addresses` table, associating the invoice with appropriate addresses.

## Diagram ERD

![Bazy danych (2)](https://github.com/user-attachments/assets/b7668a57-048d-4120-af5c-3def63634eb5)

## Views for the Database

### **1. View: View_Orders_Customers**

| Field Name         | Data Type        | Description                                    |
|--------------------|------------------|------------------------------------------------|
| `order_id`         | `INT`            | Unique identifier for the order.               |
| `order_date`       | `DATE`           | The date when the order was placed.            |
| `order_status`     | `VARCHAR(20)`    | The current status of the order.               |
| `customer_name`    | `VARCHAR(25)`    | The first name of the customer.                |
| `customer_surname` | `VARCHAR(25)`    | The surname of the customer.                   |
| `customer_email`   | `VARCHAR(50)`    | The email address of the customer.             |

**Description**:  
This view retrieves information about orders along with customer details. It joins the `Orders` table with the `Customers` table, displaying order ID, order date, status, and the customer's name, surname, and email.

---

### **2. View: view_invoices**

| Field Name         | Data Type        | Description                                    |
|--------------------|------------------|------------------------------------------------|
| `invoice_id`       | `INT`            | Unique identifier for the invoice.             |
| `invoice_number`   | `VARCHAR(50)`    | Unique number assigned to the invoice.         |
| `invoice_date`     | `DATE`           | The date when the invoice was created.         |
| `due_date`         | `DATE`           | The due date for payment of the invoice.       |
| `total_amount`     | `DECIMAL(10, 2)` | The total amount for the invoice.              |
| `tax_amount`       | `DECIMAL(10, 2)` | The tax amount applied to the invoice.         |
| `discount_amount`  | `DECIMAL(10, 2)` | The discount applied to the invoice.           |
| `invoice_status`   | `VARCHAR(10)`    | The current status of the invoice.             |
| `customer_name`    | `VARCHAR(25)`    | The first name of the customer.                |
| `customer_surname` | `VARCHAR(25)`    | The surname of the customer.                   |
| `order_date`       | `DATE`           | The date when the associated order was placed. |

**Description**:  
This view retrieves information about invoices along with associated customer and order details. It joins the `Invoices` table with the `Customers` table and optionally with the `Orders` table to display invoice details such as total amount, tax, discount, status, and customer information.

---

### **3. View: view_products_inventory**

| Field Name         | Data Type        | Description                                    |
|--------------------|------------------|------------------------------------------------|
| `product_id`       | `INT`            | Unique identifier for the product.             |
| `product_name`     | `VARCHAR(25)`    | The name of the product.                       |
| `description`      | `TEXT`           | A detailed description of the product.         |
| `actual_price`     | `DECIMAL(10, 2)` | The current price of the product.              |
| `category`         | `VARCHAR(50)`    | The category to which the product belongs.     |
| `size`             | `VARCHAR(10)`    | The size of the product.                       |
| `stock_quantity`   | `INT`            | The quantity of the product in stock.          |
| `last_updated`     | `DATE`           | The date when the inventory was last updated.  |

**Description**:  
This view combines data from the `Products` and `Inventory` tables to display detailed information about products along with their stock levels. It shows product name, description, category, price, size, and current stock quantity.

---


## Example SELECT queries
### **1. Retrieve all products with their current price and category**
```sql
SELECT product_id, name, actual_price, category FROM Products;
```
### **2. Retrieve all customers with their email and phone_number**
```sql
SELECT name, surname, email, phone_number FROM customers;
```
### **3. Retrieve all customers with billing or shipping addresses**
``` sql
 SELECT c.name, c.surname, a.* FROM customers c JOIN addresses a ON c.billing_address_id = a.address_id;
 SELECT c.name, c.surname, a.* FROM customers c JOIN addresses a ON c.shipping_address_id = a.address_id;
```
### **4. Retrieve all opinions with user name, user surname and rated product name**
``` sql
SELECT c.name, c.surname, p.name AS "rated product name", o.comment, o.rating FROM opinions o
JOIN products p USING(product_id)
JOIN customers c USING(customer_id);
```
### **5. Retrieve products with the most opinions and with average rating**
```sql
SELECT p.name, count(o.comment) AS "number of opinions", ROUND(AVG(o.rating), 2) AS "average rating" FROM products p
JOIN opinions o USING(product_id)
GROUP BY p.name ORDER BY count(o.comment) desc;
```
### **6. Retrieve orders with payment status**
```sql
SELECT o.order_id, o.order_date, p.payment_status FROM orders o JOIN payments p ON o.order_id = p.order_id;
```
### **7. Retrieve highest-paying customer**
```sql
SELECT c.name, SUM(p.amount) AS total_spent FROM customers c
JOIN orders o  USING(customer_id) JOIN payments p USING(order_id)
GROUP BY c.customer_id ORDER BY total_spent DESC LIMIT 1;
```

## Database Stored Procedures (Functions)

This section outlines the functionality and provides usage examples for the stored procedures (functions) created for the database. These functions encapsulate common database operations, making them reusable and efficient.

### Functionality

These stored procedures provide the following functionalities:

1.  **`calculate_average_rating(product_id_input INT)`:**
    *   Calculates the average rating for a specified product.
    *   Useful for displaying product ratings on your application.

2.  **`calculate_order_total(order_id_input INT)`:**
    *   Calculates the total amount for a given order.
    *   Helpful for summarizing order costs.

3.  **`get_products_by_category(category_name_input VARCHAR)`:**
    *   Retrieves all products belonging to a specific category.
    *   Useful for filtering and displaying products by category.

4.  **`get_customer_orders(customer_id_input INT)`:**
    *   Retrieves all orders placed by a specific customer.
    *   Helpful for displaying customer order history.

5.  **`get_invoice_details(invoice_id_input INT)`:**
    *   Retrieves detailed information for a specific invoice, including customer details and addresses.
    *   Useful for generating invoice reports or displaying invoice summaries.

### Usage Examples

Here are examples of how to use these stored procedures:

1.  **Calculating Average Rating:**
    ```sql
    SELECT calculate_average_rating(1); -- Replace 1 with the actual product ID
    ```
    This will return the average rating of product with `product_id` of `1`.

2.  **Calculating Order Total:**
    ```sql
    SELECT calculate_order_total(1); -- Replace 1 with the actual order ID
    ```
    This will return the total amount of order with `order_id` of `1`.

3.  **Getting Products by Category:**
    ```sql
    SELECT * FROM get_products_by_category('Clothing'); -- Replace 'Clothing' with the actual category
    ```
    This will return all products that belong to the `Clothing` category.

4.  **Getting Customer Orders:**
      ```sql
      SELECT * FROM get_customer_orders(1); -- Replace 1 with the actual customer ID
     ```
     This will return all orders that are associated to the customer with `customer_id` of `1`

5.  **Getting Invoice Details:**
    ```sql
    SELECT * FROM get_invoice_details(1); -- Replace 1 with the actual invoice ID
    ```
     This will return the invoice details for invoice with `invoice_id` of `1`.

### Benefits

*   **Reusability:** These functions can be called from various parts of your application, reducing code duplication.
*   **Maintainability:** Changes to common database operations can be made in a single place.
*   **Efficiency:** Server-side logic can be more efficient than fetching data and then processing it in the application.
*   **Simplicity:** Using procedures allows for simpler queries in your app code, as most of the logic is encapsulated within the procedures.

## Database Triggers

This section describes the database triggers created for the database. These triggers automatically execute specific actions when certain events occur, helping to maintain data integrity and automate tasks.

### Trigger Functionality

These triggers provide the following functionalities:

1.  **`update_lowest_price_trigger`:**
    *   **Function:**  Automatically updates the `lowest_price_30` column in the `Products` table whenever a product's `actual_price` is updated to a lower value.
    *   **Use Case:** Ensures the database tracks the lowest price of a product in the last 30 days, updating this value in real-time.

2.  **`update_inventory_on_order_trigger`:**
    *   **Function:** Automatically decreases the `stock_quantity` of a product in the `Inventory` table whenever a new order is created or updated, assuming a one-to-one relationship between order items and inventory.
    *   **Use Case:** Automatically manages inventory levels as new orders are placed, ensuring stock records are up-to-date.

3.  **`set_updated_at_trigger`:**
    *   **Function:** Automatically sets the `updated_at` timestamp in the `Invoices` table whenever an invoice record is updated.
    *   **Use Case:** Keeps a record of when an invoice was last modified, ensuring timestamps are updated consistently.

4.  **`prevent_duplicate_opinions_trigger`:**
    *   **Function:** Prevents customers from adding multiple opinions for the same product.
    *   **Use Case:** Ensures that each customer can leave only one opinion for a specific product, maintaining the quality and authenticity of opinions.

### Usage Examples

These triggers work automatically in the background; no direct calls are needed. Below are examples that illustrate how these triggers work through normal operations:

1.  **Updating the Lowest Price:**
    ```sql
    -- Update the actual price of a product to trigger the lowest_price_30 update.
    UPDATE Products SET actual_price = 10.00 WHERE product_id = 1;
    -- This update will trigger the update of the lowest_price_30 field
    ```

2.  **Updating Inventory on New Order:**
  ```sql
   -- Insert a new order and it will decrease the inventory if new record in order table has `product_id` and `size` fields
   INSERT INTO Orders(customer_id, order_date, status, product_id, size) VALUES (1, CURRENT_DATE, 'Pending', 1, 'M')
   -- This will trigger decrement of quantity of product with id = 1 and size = M
  ```

3.  **Updating Invoice `updated_at`:**
    ```sql
    -- Update an existing invoice to trigger the updated_at timestamp update.
    UPDATE Invoices SET status = 'Paid' WHERE invoice_id = 1;
    -- This will trigger an update to updated_at column
    ```

4.  **Preventing Duplicate Opinions:**
    ```sql
      -- inserting opinions
     INSERT INTO Opinions(product_id, customer_id, rating) VALUES (1,1,5); -- this one is ok
     INSERT INTO Opinions(product_id, customer_id, rating) VALUES (1,1,1); -- this one will fail
    -- The second insert operation will raise an exception and prevent duplicate opinion
    ```

### Benefits

*   **Automation:** Triggers automate tasks that would otherwise require manual intervention.
*   **Data Integrity:** Triggers help enforce data integrity by applying rules automatically before or after changes to the database.
*   **Consistency:** Triggers help maintain consistency across different parts of the database.
*   **Real-Time Updates:** Triggers perform updates in real-time without requiring application intervention.
*   **Code Simplification:** Triggers encapsulate data logic, reducing complexity in application code.
