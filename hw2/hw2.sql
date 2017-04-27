/* Using postgresql with postgis */

CREATE DATABASE spatialhw
  WITH OWNER = postgres
       ENCODING = 'UTF8'
       TABLESPACE = pg_default
       LC_COLLATE = 'C'
       LC_CTYPE = 'C'
       CONNECTION LIMIT = -1;

CREATE EXTENSION postgis;
CREATE EXTENSION postgis_topology;

DROP TABLE IF EXISTS points;
CREATE TABLE points (id serial);
SELECT AddGeometryColumn ('public','points','geom',4326,'POINT',2);

DELETE FROM points;

INSERT INTO points VALUES (1, ST_SetSRID(ST_MAKEPOINT(-118.288235,34.028985), 4326));
INSERT INTO points VALUES (2, ST_SetSRID(ST_MAKEPOINT(-118.288035,34.024287), 4326));
INSERT INTO points VALUES (3, ST_SetSRID(ST_MAKEPOINT(-118.286431,34.020778), 4326));
INSERT INTO points VALUES (4, ST_SetSRID(ST_MAKEPOINT(-118.282545,34.021699), 4326));
INSERT INTO points VALUES (5, ST_SetSRID(ST_MAKEPOINT(-118.280126,34.021901), 4326));
INSERT INTO points VALUES (6, ST_SetSRID(ST_MAKEPOINT(-118.282349,34.018401), 4326));
INSERT INTO points VALUES (7, ST_SetSRID(ST_MAKEPOINT(-118.291478,34.018375), 4326));
INSERT INTO points VALUES (8, ST_SetSRID(ST_MAKEPOINT(-118.291486,34.025437), 4326));
INSERT INTO points VALUES (9, ST_SetSRID(ST_MAKEPOINT(-118.289304,34.021224), 4326));

SELECT * FROM points;

/* Query 1 - convex hull*/
SELECT ST_AsText(ST_ConvexHull(
	ST_Collect(geom)))
FROM points;


/* Query 2 - Nearest neighbours */
SELECT ST_ASTEXT(geom)
FROM points 
WHERE id != 1
ORDER BY points.geom <-> (SELECT geom from POINTS where ID = 1)
LIMIT 3;