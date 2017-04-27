-- Use SQLite for all queries. Tested it on my personal local computer copy and on an online SQL tool - ideone.com

CREATE TABLE dishes (
  Chef VARCHAR(20) NOT NULL,
  Dish VARCHAR(50) NOT NULL,
  UNIQUE(Chef, Dish)
);


CREATE TABLE dishes_required (
  Dish VARCHAR(50) NOT NULL UNIQUE
);


DELETE FROM dishes;

DELETE FROM dishes_required;

INSERT INTO dishes_required VALUES 
('Apple pie'),
('Upside down pineapple cake'),
('Creme brulee');

INSERT INTO dishes VALUES
('A', 'Mint chocolate brownie'),
('B', 'Upside down pineapple cake'),
('B', 'Creme brulee'),
('B', 'Mint chocolate brownie'),
('C', 'Upside down pineapple cake'),
('C', 'Creme brulee'),
('D', 'Apple pie'),
('D', 'Upside down pineapple cake'),
('D', 'Creme brulee'),
('F', 'Apple pie'),
('F', 'Upside down pineapple cake'),
('G', 'Creme brulee'),
('E', 'Apple pie'),
('E', 'Upside down pineapple cake'),
('E', 'Creme brulee'),
('E', 'Bananas Foster');


SELECT x.Chef 
FROM (
SELECT a.Chef, COUNT(*) cnt
FROM dishes a
WHERE Dish IN (SELECT Dish FROM dishes_required)
  GROUP BY a.Chef
  HAVING cnt = (SELECT COUNT(*) FROM dishes_required)
) x;


