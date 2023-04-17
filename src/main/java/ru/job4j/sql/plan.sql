CREATE TABLE users (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    username text NOT NULL
);

INSERT INTO users (username)
SELECT 'person' || n
FROM generate_series(1, 1000) AS n;

select * from users;
EXPLAIN SELECT * FROM users ORDER BY username;
EXPLAIN SELECT * FROM users LIMIT 1000;
EXPLAIN SELECT * FROM users LIMIT 1;
EXPLAIN SELECT count(*) FROM users;
SELECT reltuples, relpages FROM pg_class WHERE relname = 'users';
SELECT *FROM pg_class WHERE relname = 'users';
EXPLAIN ANALYZE SELECT * FROM users ORDER BY username;
CREATE INDEX people_username_index ON users(username);
EXPLAIN ANALYZE SELECT * FROM users ORDER BY username;
ANALYZE users;