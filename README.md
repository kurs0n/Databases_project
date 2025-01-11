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

## Dokumentacja

### Database structure

 **Table: Products**

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

**Table: Addresses**

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

**Table: Customers**

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

**Table: Orders**

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
  
**Table: Payments**

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
  
**Table: Inventory**

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
    
**Table: Opinions**

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

**Table: Invoices**

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
