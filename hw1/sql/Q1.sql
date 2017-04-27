/*
Used POSTGRESQL from http://rextester.com/l/postgresql_online_compiler

The problem poses two issues:
1. Arrival date greater than departure date
2. Overlapping date ranges with the same room Number

I've proposed two solutions for the above problem as follows:

*/



/*
Solution1: Used Postgres SQL for the below

For the first problem we can add a CHECK constraint as follows which would prevent adding any row which has an arrival date greater than the departure date

ALTER TABLE HotelStays ADD CONSTRAINT dep_date_arr_date
CHECK (depDate > arrDate);

Here the constraint dep_date_arr_date ensures that departure date is always greater than (can be made greater than or equal to if required) the arrival date.

For the second problem we cannot use CHECK constraint as all constraints work on the row being inserted / updated. Therefore, we need to add a trigger / function that would trigger on every UPDATE/INSERT of a row. The trigger would search in the entire table if the new row being inserted or updated violates any constraint.


*/

CREATE TABLE HotelStays
(roomNum INTEGER NOT NULL,
arrDate DATE NOT NULL,
depDate DATE NOT NULL,
guestName CHAR(30) NOT NULL,
PRIMARY KEY (roomNum, arrDate));

ALTER TABLE HotelStays ADD CONSTRAINT dep_date_arr_date
CHECK (depDate > arrDate);

CREATE OR REPLACE FUNCTION overlap_date_check_proc()
RETURNS trigger AS
$BODY$
BEGIN

IF EXISTS(SELECT roomNum FROM HotelStays WHERE roomNum = NEW.roomNum and (NEW.arrDate BETWEEN arrDate AND depDate OR NEW.depDate BETWEEN arrDate AND depDate)) THEN
RETURN OLD;
END IF;
RETURN NEW;
END;
$BODY$ LANGUAGE plpgsql;


CREATE TRIGGER hotelstays_trigger
BEFORE INSERT OR UPDATE
ON HotelStays
FOR EACH ROW 
EXECUTE PROCEDURE overlap_date_check_proc();


DELETE FROM HotelStays;

INSERT INTO HotelStays(roomNum, arrDate, depDate, guestName)
VALUES 
(123, to_date('20160202', 'YYYYMMDD'), to_date('20160206','YYYYMMDD'), 'A'),
(123, to_date('20160204', 'YYYYMMDD'), to_date('20160208','YYYYMMDD'), 'B'),
(201, to_date('20160201', 'YYYYMMDD'), to_date('20160206','YYYYMMDD'), 'C');

SELECT * FROM HotelStays;

/* Solution 2: All the above can be achieved using PostGres 9.3. Used Postgres SQL for the below query. Tested it on my personal local computer copy, and had all admin permissions to run CREATE EXTENSION queries. 
POSTGRES offers this trigger functionality in a predefined extension called btree_gist. Using btree_gist, we can add the constraint as follows

ALTER TABLE HotelStays ADD CONSTRAINT non_overlap_date
EXCLUDE USING GIST
    ( roomNum WITH =, 
      daterange(arrDate, depDate, '[]') WITH &&
    );

The constraint would check for any overlapping date ranges for the current row with all the existing rows of the table having the same roomNum
*/

CREATE EXTENSION IF NOT EXISTS btree_gist;

CREATE TABLE HotelStays
(roomNum INTEGER NOT NULL,
arrDate DATE NOT NULL,
depDate DATE NOT NULL,
guestName CHAR(30) NOT NULL,
PRIMARY KEY (roomNum, arrDate));

ALTER TABLE HotelStays ADD CONSTRAINT dep_date_arr_date
CHECK (depDate > arrDate);

ALTER TABLE HotelStays ADD CONSTRAINT non_overlap_date
EXCLUDE USING GIST
    ( roomNum WITH =, 
      daterange(arrDate, depDate, '[]') WITH &&
    );

DELETE FROM HotelStays;

INSERT INTO HotelStays(roomNum, arrDate, depDate, guestName)
VALUES 
(123, to_date('20160202', 'YYYYMMDD'), to_date('20160206','YYYYMMDD'), 'A'),
(123, to_date('20160204', 'YYYYMMDD'), to_date('20160208','YYYYMMDD'), 'B'),
(201, to_date('20160210', 'YYYYMMDD'), to_date('20160206','YYYYMMDD'), 'C');

SELECT * FROM HotelStays;


