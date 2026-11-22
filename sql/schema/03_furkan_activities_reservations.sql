-- Team Dynamix - BBF 302E
-- Owner: Furkan Özkan
-- Tables: activities, activity_participants, reservations
-- Matches Milestone 2, Section 6, Tables 9-11.

CREATE TABLE activities (
    activity_id          INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    trip_id              INTEGER       NOT NULL
                                       REFERENCES trips(trip_id) ON DELETE CASCADE,
    activity_type_id     INTEGER       NOT NULL
                                       REFERENCES activity_types(activity_type_id),
    created_by           INTEGER       NOT NULL REFERENCES users(user_id),
    title                VARCHAR(150)  NOT NULL,
    activity_date        DATE          NOT NULL,
    start_time           TIME,
    end_time             TIME,
    location             VARCHAR(200),
    est_cost_per_person  NUMERIC(12,2) CHECK (est_cost_per_person >= 0),
    notes                TEXT,
    created_at           TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CHECK (end_time IS NULL OR start_time IS NULL OR end_time > start_time)
);

CREATE TABLE activity_participants (
    activity_id  INTEGER     NOT NULL
                             REFERENCES activities(activity_id) ON DELETE CASCADE,
    user_id      INTEGER     NOT NULL REFERENCES users(user_id),
    status       VARCHAR(10) NOT NULL
                             CHECK (status IN ('going', 'maybe', 'not_going')),
    updated_at   TIMESTAMP   NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (activity_id, user_id)
);

CREATE TABLE reservations (
    reservation_id     INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    trip_id            INTEGER       NOT NULL
                                     REFERENCES trips(trip_id) ON DELETE CASCADE,
    activity_id        INTEGER       REFERENCES activities(activity_id)
                                     ON DELETE SET NULL,
    created_by         INTEGER       NOT NULL REFERENCES users(user_id),
    reservation_type   VARCHAR(20)   NOT NULL
                                     CHECK (reservation_type IN ('accommodation', 'flight',
                                            'transport', 'restaurant', 'ticket', 'other')),
    provider           VARCHAR(100)  NOT NULL,
    confirmation_code  VARCHAR(50),
    start_datetime     TIMESTAMP     NOT NULL,
    end_datetime       TIMESTAMP,
    address            VARCHAR(255),
    cost               NUMERIC(12,2) NOT NULL CHECK (cost >= 0),
    currency_code      CHAR(3)       NOT NULL REFERENCES currencies(currency_code),
    status             VARCHAR(10)   NOT NULL DEFAULT 'pending'
                                     CHECK (status IN ('pending', 'confirmed', 'cancelled')),
    created_at         TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at         TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CHECK (end_datetime IS NULL OR end_datetime >= start_datetime)
);
