-- Team Dynamix - BBF 302E
-- Owner: Ömer Faruk Güveloğlu
-- Tables: payments, notifications
-- Matches Milestone 2, Section 6, Tables 14-15.

CREATE TABLE payments (
    payment_id     INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    -- RESTRICT: a trip with payments cannot be deleted, only archived (FR-07).
    trip_id        INTEGER       NOT NULL
                                 REFERENCES trips(trip_id) ON DELETE RESTRICT,
    payer_id       INTEGER       NOT NULL REFERENCES users(user_id),
    receiver_id    INTEGER       NOT NULL REFERENCES users(user_id),
    amount         NUMERIC(12,2) NOT NULL CHECK (amount > 0),
    currency_code  CHAR(3)       NOT NULL REFERENCES currencies(currency_code),
    exchange_rate  NUMERIC(14,6) NOT NULL CHECK (exchange_rate > 0),
    payment_date   DATE          NOT NULL,
    method         VARCHAR(15)   NOT NULL
                                 CHECK (method IN ('cash', 'bank_transfer', 'card', 'other')),
    note           VARCHAR(255),
    status         VARCHAR(10)   NOT NULL DEFAULT 'pending'
                                 CHECK (status IN ('pending', 'confirmed', 'rejected')),
    created_at     TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    responded_at   TIMESTAMP,
    CHECK (receiver_id <> payer_id)
);

CREATE TABLE notifications (
    notification_id  INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    user_id          INTEGER      NOT NULL
                                  REFERENCES users(user_id) ON DELETE CASCADE,
    trip_id          INTEGER      REFERENCES trips(trip_id) ON DELETE CASCADE,
    notif_type       VARCHAR(30)  NOT NULL
                                  CHECK (notif_type IN ('invitation', 'expense_added',
                                         'expense_changed', 'activity_deleted',
                                         'payment_to_confirm', 'payment_status',
                                         'reservation_status')),
    message          VARCHAR(255) NOT NULL,
    is_read          BOOLEAN      NOT NULL DEFAULT FALSE,
    created_at       TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP
);
