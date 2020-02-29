
DROP TABLE merchant_category;

CREATE TABLE merchant_category(
id SERIAL PRIMARY KEY,
name VARCHAR,
FOREIGN KEY (id) REFERENCES merchant (id)
);

INSERT INTO merchant_category VALUES
    (1, 'restaurant'),
    (2, 'coffee shop'),
    (3, 'bar'),
    (4, 'pub'),
    (5, 'food truck');

SELECT * 
FROM merchant_category;
