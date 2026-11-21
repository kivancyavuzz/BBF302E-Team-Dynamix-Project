# Group Travel Expense & Activity Planner

BBF 302E Database Systems term project, Fall 2026, by **Team Dynamix**.

A Flask web application where a group plans a trip together: destinations,
a day-by-day itinerary, reservations, shared expenses split between members,
balances, settlement suggestions and payments between members.

## Team

| Member | Area | Tables |
| --- | --- | --- |
| Kıvanç Yavuz (Team Leader) | Authentication, user accounts, admin panel | currencies, users, expense_categories, activity_types |
| Burak Ceylan | Trips, destinations, invitations, membership | trips, trip_destinations, trip_members, trip_invitations |
| Furkan Özkan | Activities, itinerary, reservations | activities, activity_participants, reservations |
| Rabia Yıldız | Expenses, expense splitting, reports | expenses, expense_shares |
| Ömer Faruk Güveloğlu | Payments, balances, notifications | payments, notifications |

## Tech stack

- PostgreSQL 16 (compatible with 15+); SQLite is not used
- Python Flask with Jinja2 templates
- psycopg2 with raw, parameterized SQL; no ORM

## Repository structure

```
docs/                 milestone reports and the ER diagram
sql/
  schema.sql          builds the whole database in dependency order
  schema/             one file per member, run in numeric order
```

## Creating the database

1. Install PostgreSQL 16 and make sure `psql` is on your PATH.
2. Create an empty database:
   ```
   psql -U postgres -c "CREATE DATABASE team_dynamix"
   ```
3. Build all tables from the repository root:
   ```
   psql -U postgres -d team_dynamix -f sql/schema.sql
   ```
   The script first drops existing tables, so it can be run again at any time.
   It creates 15 tables and 33 foreign keys.
