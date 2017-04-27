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


SELECT DISTINCT x.Chef 
FROM Dishes y 
JOIN (
SELECT c.Chef, COUNT(*) as count_1
FROM (
SELECT a.Chef, a.Dish
FROM dishes_required b
LEFT JOIN dishes a
  ON (a.Dish = b.dish)
) c
GROUP BY c.Chef
HAVING count_1 = (SELECT COUNT(*) FROM dishes_required)
)x ON x.Chef = y.Chef;




