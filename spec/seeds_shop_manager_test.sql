TRUNCATE TABLE inventory RESTART IDENTITY CASCADE;
TRUNCATE TABLE orders RESTART IDENTITY CASCADE;

INSERT INTO inventory (item, price, quantity) VALUES ('printer', 60, 8);
INSERT INTO inventory (item, price, quantity) VALUES ('mouse', 30, 12);

INSERT INTO orders (customer, date, item_id) VALUES ('John Smith', '2023-04-14', 2);
INSERT INTO orders (customer, date, item_id) VALUES ('Tim Cook', '2023-05-22', 2);