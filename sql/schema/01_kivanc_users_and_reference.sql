-- Team Dynamix - BBF 302E
-- Owner: Kıvanç Yavuz
-- Tables: currencies, users, expense_categories, activity_types
-- Matches Milestone 2, Section 6, Tables 1-4.

CREATE TABLE currencies (
    currency_code  CHAR(3)       PRIMARY KEY
                                 CHECK (currency_code ~ '^[A-Z]{3}$'),
    name           VARCHAR(50)   NOT NULL UNIQUE,
    symbol         VARCHAR(5)    NOT NULL,
    rate_to_try    NUMERIC(14,6) NOT NULL CHECK (rate_to_try > 0),
    updated_at     TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE users (
    user_id             INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    full_name           VARCHAR(100) NOT NULL,
    email               VARCHAR(255) NOT NULL UNIQUE,
    password_hash       VARCHAR(255) NOT NULL,
    phone               VARCHAR(20),
    preferred_currency  CHAR(3)      NOT NULL DEFAULT 'TRY'
                                     REFERENCES currencies(currency_code),
    system_role         VARCHAR(10)  NOT NULL DEFAULT 'user'
                                     CHECK (system_role IN ('user', 'admin')),
    is_active           BOOLEAN      NOT NULL DEFAULT TRUE,
    created_at          TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    deactivated_at      TIMESTAMP,
    CHECK (is_active OR deactivated_at IS NOT NULL)
);

CREATE TABLE expense_categories (
    category_id  INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name         VARCHAR(50)  NOT NULL UNIQUE,
    description  VARCHAR(255),
    is_active    BOOLEAN      NOT NULL DEFAULT TRUE
);

CREATE TABLE activity_types (
    activity_type_id  INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name              VARCHAR(50)  NOT NULL UNIQUE,
    description       VARCHAR(255),
    is_active         BOOLEAN      NOT NULL DEFAULT TRUE
);
