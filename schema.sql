CREATE TABLE lists (
    PRIMARY KEY (id),
    id     serial,
    "name" text   NOT NULL,
           CONSTRAINT unique_name
           UNIQUE ("name")
);

CREATE TABLE todos (
    PRIMARY KEY (id),
    id        serial,
    "name"    text    NOT NULL,
    completed boolean NOT NULL DEFAULT false,
    list_id   integer NOT NULL,
              FOREIGN KEY (list_id)
              REFERENCES lists (id)
              ON DELETE CASCADE
);
