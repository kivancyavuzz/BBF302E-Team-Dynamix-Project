-- Team Dynamix - BBF 302E
-- Drops every table so the schema can be rebuilt from scratch.
-- Order is the reverse of creation; CASCADE also removes dependent indexes.

DROP TABLE IF EXISTS notifications         CASCADE;
DROP TABLE IF EXISTS payments              CASCADE;
DROP TABLE IF EXISTS expense_shares        CASCADE;
DROP TABLE IF EXISTS expenses              CASCADE;
DROP TABLE IF EXISTS reservations          CASCADE;
DROP TABLE IF EXISTS activity_participants CASCADE;
DROP TABLE IF EXISTS activities            CASCADE;
DROP TABLE IF EXISTS trip_invitations      CASCADE;
DROP TABLE IF EXISTS trip_members          CASCADE;
DROP TABLE IF EXISTS trip_destinations     CASCADE;
DROP TABLE IF EXISTS trips                 CASCADE;
DROP TABLE IF EXISTS activity_types        CASCADE;
DROP TABLE IF EXISTS expense_categories    CASCADE;
DROP TABLE IF EXISTS users                 CASCADE;
DROP TABLE IF EXISTS currencies            CASCADE;
