-- Use SQLite for all queries. Tested it on my personal local computer copy and on an online SQL tool - ideone.com

CREATE TABLE project (
  ProjectID VARCHAR(20) NOT NULL,
  Step NUMERIC NOT NULL,
  Status VARCHAR(2) NOT NULL,
  UNIQUE(ProjectId, Step)
);


DELETE FROM project;

INSERT INTO project VALUES
('P100', 0, 'C'),
('P100', 1, 'W'),
('P100', 2, 'W'),
('P201', 0, 'C'),
('P201', 1, 'C'),
('P333', 0, 'W'),
('P333', 1, 'W'),
('P333', 2, 'W'),
('P333', 3, 'W');

SELECT Distinct ProjectID
FROM project
WHERE ProjectID NOT IN (
	SELECT Distinct ProjectID
	FROM project
	WHERE Status = 'C'
	AND Step > 0)
AND Status = 'C'
	AND Step = 0;

	


