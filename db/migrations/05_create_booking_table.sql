CREATE TABLE booking(id SERIAL PRIMARY KEY, listing_id INTEGER REFERENCES listing (id), visitor_id INTEGER REFERENCES users (id), status VARCHAR(12));