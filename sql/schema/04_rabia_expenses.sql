-- Team Dynamix - BBF 302E
-- Owner: Rabia Yıldız
-- Tables: expenses, expense_shares
-- Matches Milestone 2, Section 6, Tables 12-13.

CREATE TABLE expenses (
    expense_id      INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    -- RESTRICT: a trip with expenses cannot be deleted, only archived (FR-07).
    trip_id         INTEGER       NOT NULL
                                  REFERENCES trips(trip_id) ON DELETE RESTRICT,
    category_id     INTEGER       NOT NULL
                                  REFERENCES expense_categories(category_id),
    paid_by         INTEGER       NOT NULL REFERENCES users(user_id),
    created_by      INTEGER       NOT NULL REFERENCES users(user_id),
    activity_id     INTEGER       REFERENCES activities(activity_id)
                                  ON DELETE SET NULL,
    -- UNIQUE: a reservation can be converted into an expense only once (FR-15).
    reservation_id  INTEGER       UNIQUE
                                  REFERENCES reservations(reservation_id)
                                  ON DELETE SET NULL,
    description     VARCHAR(200)  NOT NULL,
    amount          NUMERIC(12,2) NOT NULL CHECK (amount > 0),
    currency_code   CHAR(3)       NOT NULL REFERENCES currencies(currency_code),
    -- Rate to the trip base currency at recording time (NFR-10).
    exchange_rate   NUMERIC(14,6) NOT NULL CHECK (exchange_rate > 0),
    expense_date    DATE          NOT NULL,
    split_method    VARCHAR(10)   NOT NULL
                                  CHECK (split_method IN ('equal', 'exact', 'percentage')),
    created_at      TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- The rule "shares of an expense sum to its amount" is checked in the
-- same transaction in the Flask code (NFR-04), not by a constraint.
CREATE TABLE expense_shares (
    expense_id    INTEGER       NOT NULL
                                REFERENCES expenses(expense_id) ON DELETE CASCADE,
    user_id       INTEGER       NOT NULL REFERENCES users(user_id),
    share_amount  NUMERIC(12,2) NOT NULL CHECK (share_amount >= 0),
    PRIMARY KEY (expense_id, user_id)
);
