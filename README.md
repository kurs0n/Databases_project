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

**Table Products**          
| Field Name    | Data Type       | Length | Description                                                         |
|---------------|-----------------|--------|---------------------------------------------------------------------|
| `id`          | `SERIAL`        | -      | Unique identifier for each product.                                 |
| `name`        | `VARCHAR`       | 255    | The name of the product.                                            |
| `description` | `TEXT`          | -      | A detailed description of the product (optional).                   |
| `price`       | `NUMERIC(10, 2)`| -      | The price of the product, with up to 10 digits and 2 decimal places.|
| `created_at`  | `TIMESTAMP`     | -      | Timestamp when the product was added, defaults to current timestamp.|

**Notes**
- **Primary Key**: The `id` column uniquely identifies each product in the table.
- **Mandatory Fields**: Both `name` and `price` must have values (`NOT NULL` constraint).
- **Default Values**: The `created_at` column automatically records the current timestamp when a new record is added.
- **Precision in Price**: The `price` column supports up to 10 total digits with 2 digits after the decimal point (e.g., `99999999.99`).

**Table Users** 
| Field Name      | Data Type       | Length | Description                                                         |
|------------------|-----------------|--------|--------------------------------------------------------------------|
| `id`            | `SERIAL`        | -      | Unique identifier for each user.                                    |
| `username`      | `VARCHAR`       | 50     | The username chosen by the user, must be unique.                    |
| `email`         | `VARCHAR`       | 100    | The user's email address, must be unique.                           |
| `password_hash` | `VARCHAR`       | 255    | Hashed password for secure authentication.                          |
| `created_at`    | `TIMESTAMP`     | -      | Timestamp when the user was registered, defaults to current time.   |

**Notes**
- **Primary Key**: The `id` column uniquely identifies each user in the table.
- **Unique Fields**: Both `username` and `email` must be unique to ensure no duplicates.
- **Mandatory Fields**: The `username`, `email`, and `password_hash` fields are required (`NOT NULL` constraint).
- **Default Values**: The `created_at` column automatically records the current timestamp when a new user is added.

**Table Orders**
| Field Name      | Data Type       | Length | Description                                                         |
|------------------|-----------------|--------|--------------------------------------------------------------------|
| `id`            | `SERIAL`        | -      | Unique identifier for each order.                                   |
| `user_id`       | `INT`           | -      | User ID (`id` from the `users` table) who placed the order.         |
| `total_value`   | `NUMERIC(10, 2)`| -      | Total value of the order, with up to 2 decimal places.              |
| `created_at`    | `TIMESTAMP`     | -      | Timestamp when the order was created, defaults to current time.     |

**Notes**
- **Primary Key**: The `id` column uniquely identifies each order.
- **Foreign Key**: The `user_id` column references the `id` column in the `users` table to associate orders with users.
- **Default Values**: The `created_at` column automatically records the current timestamp when a new order is added.

**Table OrderItems**
| Field Name    | Data Type       | Length | Description                                                         |
|---------------|-----------------|--------|---------------------------------------------------------------------|
| `id`          | `SERIAL`        | -      | Unique identifier for each order item.                              |
| `order_id`    | `INT`           | -      | ID of the order (references `orders.id`).                           |
| `product_id`  | `INT`           | -      | ID of the product (references `products.id`).                       |
| `quantity`    | `INT`           | -      | Quantity of the product ordered.                                    |
| `price`       | `NUMERIC(10, 2)`| -      | Price of the product at the time of the order.                      |

**Notes**
- **Primary Key**: The `id` column uniquely identifies each order item.
- **Foreign Key**: 
  - `order_id` references the `id` column in the `orders` table.
  - `product_id` references the `id` column in the `products` table.
- **Price**: The `price` field stores the price of the product at the time of the order, which may differ from the current product price.
