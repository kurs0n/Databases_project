# Databases_project

## How-To-Run

make sure that You have docker 

1. `make run_container`
2. `make migrate_files`


## workflow

add migration files like that:

if the last element is 002 -> You should add to migration folder 003_[what You have done] 

create pr!


Wymagania ogólne:

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