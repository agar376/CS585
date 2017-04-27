-- Use SQLite for all queries. Tested it on my personal local computer copy and on an online SQL tool - ideone.com

CREATE TABLE mail (
  Name VARCHAR(20) NOT NULL,
  Address VARCHAR(20) NOT NULL,
  ID NUMERIC NOT NULL UNIQUE,
  SameFam Numeric
);


DELETE FROM mail;

INSERT INTO mail VALUES
('Alice', 'A', 10, NULL),
('Bob', 'B', 15, NULL),
('Carmen', 'C', 22, NULL),
('Diego', 'A', 9, 10),
('Ella', 'B', 3, 15),
('Farkhad', 'D', 11, NULL);


DELETE FROM mail
WHERE ID IN (
  SELECT fam.ID
FROM mail m
LEFT JOIN mail fam ON m.SameFam = fam.ID
WHERE m.Address = fam.Address
AND fam.SameFam IS NULL
);

SELECT * FROM mail;
