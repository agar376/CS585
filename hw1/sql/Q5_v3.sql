-- Use SQL Server 2014 for all queries. Tested it on my personal local computer copy and on an online SQL tool - sqlfiddle.com - MySQL 5.6

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


SELECT a.Chef 
FROM (
SELECT Chef, GROUP_CONCAT(Dish, '%') as combined_dish
FROM (	SELECT * FROM Dishes ORDER BY Chef, Dish)
GROUP BY Chef
ORDER BY Chef, combined_dish
) a
WHERE a.combined_dish LIKE '%' || (SELECT GROUP_CONCAT(Dish, '%') as c_dish FROM (SELECT * FROM dishes_required ORDER BY Dish)) || '%';





