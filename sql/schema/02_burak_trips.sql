-- Team Dynamix - BBF 302E
-- Owner: Burak Ceylan
-- Tables: trips, trip_destinations, trip_members, trip_invitations
-- Matches Milestone 2, Section 6, Tables 5-8.

CREATE TABLE trips (
    trip_id        INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name           VARCHAR(100) NOT NULL,
    description    TEXT,
    start_date     DATE         NOT NULL,
    end_date       DATE         NOT NULL,
    base_currency  CHAR(3)      NOT NULL REFERENCES currencies(currency_code),
    status         VARCHAR(10)  NOT NULL DEFAULT 'active'
                                CHECK (status IN ('active', 'archived')),
    created_by     INTEGER      NOT NULL REFERENCES users(user_id),
    created_at     TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    archived_at    TIMESTAMP,
    CHECK (end_date >= start_date),
    CHECK (status = 'active' OR archived_at IS NOT NULL)
);

CREATE TABLE trip_destinations (
    destination_id  INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    trip_id         INTEGER      NOT NULL
                                 REFERENCES trips(trip_id) ON DELETE CASCADE,
    city            VARCHAR(100) NOT NULL,
    country         VARCHAR(100) NOT NULL,
    arrival_date    DATE         NOT NULL,
    departure_date  DATE         NOT NULL,
    stop_order      SMALLINT     NOT NULL CHECK (stop_order > 0),
    CHECK (departure_date >= arrival_date),
    UNIQUE (trip_id, stop_order)
);

CREATE TABLE trip_members (
    trip_id      INTEGER     NOT NULL
                             REFERENCES trips(trip_id) ON DELETE CASCADE,
    user_id      INTEGER     NOT NULL REFERENCES users(user_id),
    member_role  VARCHAR(10) NOT NULL DEFAULT 'member'
                             CHECK (member_role IN ('organizer', 'member')),
    joined_at    TIMESTAMP   NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (trip_id, user_id)
);

CREATE TABLE trip_invitations (
    invitation_id    INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    trip_id          INTEGER     NOT NULL
                                 REFERENCES trips(trip_id) ON DELETE CASCADE,
    invited_user_id  INTEGER     NOT NULL REFERENCES users(user_id),
    invited_by       INTEGER     NOT NULL REFERENCES users(user_id),
    status           VARCHAR(10) NOT NULL DEFAULT 'pending'
                                 CHECK (status IN ('pending', 'accepted',
                                                   'declined', 'cancelled')),
    sent_at          TIMESTAMP   NOT NULL DEFAULT CURRENT_TIMESTAMP,
    responded_at     TIMESTAMP,
    CHECK (invited_by <> invited_user_id)
);

-- At most one pending invitation per user and trip (FR-09).
CREATE UNIQUE INDEX uq_one_pending_invitation
    ON trip_invitations (trip_id, invited_user_id)
    WHERE status = 'pending';
