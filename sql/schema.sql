-- Team Dynamix - BBF 302E
-- Builds the whole database. Run from any folder with:
--   psql -U postgres -d team_dynamix -f sql/schema.sql
-- \ir paths are relative to this file, so the order below is the
-- dependency order of the foreign keys.

\set ON_ERROR_STOP on

\ir schema/00_reset.sql
\ir schema/01_kivanc_users_and_reference.sql
\ir schema/02_burak_trips.sql
\ir schema/03_furkan_activities_reservations.sql
\ir schema/04_rabia_expenses.sql
\ir schema/05_omer_payments_notifications.sql
