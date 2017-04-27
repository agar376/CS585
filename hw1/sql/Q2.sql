-- Use SQLite for all queries. Tested it on my personal local computer copy and on an online SQL tool - ideone.com

CREATE TABLE student_courses (
  SID INTEGER NOT NULL,
  ClassName VARCHAR(50) NOT NULL,
  Grade VARCHAR(2)
);


DELETE FROM student_courses;

INSERT INTO student_courses VALUES
(123, 'ART123', 'A'),
(123, 'BUS456', 'B'),
(666, 'REL100', 'D'),
(666, 'ECO966', 'A'),
(666, 'BUS456', 'B'),
(345, 'BUS456', 'A'),
(345, 'ECO966', 'F');


SELECT ClassName, COUNT(*) AS Total
FROM student_courses
GROUP BY ClassName
ORDER BY Total, ClassName;



