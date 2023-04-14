CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  customer text,
  date date,
  item_id int,
  constraint fk_item foreign key(item_id)
  references inventory(id)
  on delete cascade
);