CREATE DATABASE assignment2

create Table rangers (

    ranger_id SERIAL PRIMARY key,
    name VARCHAR (50) NOT NULL,
    region VARCHAR(50) NOT NUll

);

INSERT INTO rangers (name,region) VALUES 
('Alice Green','Northern Hills'),
('Bob White','River Delta'),
('Carol King','Mountain Range');
SELECT * from rangers;

CREATE  TYPE status_type AS ENUM ('Endangered', 'Vulnerable','Historic');

create Table species (

    species_id SERIAL PRIMARY key,
    common_name VARCHAR (50) NOT NULL,
    scientific_name VARCHAR(50) NOT NUll,
    discovery_date DATE,
    conservation_status status_type

);

SELECT * from species;

INSERT INTO species (common_name,scientific_name,discovery_date,conservation_status) VALUES 
('Snow Leopard','Panthera uncia','1775-01-01','Endangered'),
('Bob White','River Delta','1758-01-01','Endangered'),
('Red Panda',' Ailurus fulgens','1825-01-01','Vulnerable'),
('Asiatic Elephant','Elephas maximus indicus','1758-01-01','Endangered');


create Table sightings (
    sightings_id SERIAL PRIMARY KEY,
    species_id INT REFERENCES species(species_id)ON DELETE CASCADE,
    ranger_id INT REFERENCES rangers(ranger_id) ON DELETE CASCADE,
    location VARCHAR (50) NOT NULL,
    sighting_time TIMESTAMP,
    notes VARCHAR DEFAULT 'no inputs'

);

-- drop Table sightings;

-- SELECT * from sightings;

INSERT INTO sightings (species_id,ranger_id,location,sighting_time,notes) VALUES 
(1,1,'peak Ridge','2024-05-10 07:45:00','Camera trap image captured'),
(2,2,'Bankwood Area','2024-05-12 16:20:00','Juvenile seen'),
(3,4,'Bamboo Grove East','2024-05-15 09:10:00','Feeding observed'),
(1,2,'Snowfall Pass','2024-05-18 18:30:00','');


-- task *************************->1
insert into rangers (name,region) VALUES
('Derek Fox','Coastal Plains')


-- task *************************->2
SELECT count(DISTINCT(species_id)) as unique_species_count from sightings;

-- task *************************->3
SELECT  * from sightings 
WHERE location ILIKE '%Pass%';

-- task *************************->4

-- SELECT name,ranger_id from rangers;

select name, count(species_id) from rangers
join sightings  on rangers.ranger_id=sightings.ranger_id
GROUP BY name;

-- task *************************->5
select common_name from species
FULL JOIN sightings  on species.species_id=sightings.species_id
where sightings_id IS NULL;

-- task *************************->6
select common_name,sighting_time,name from species
 JOIN (select * from rangers
join sightings  on rangers.ranger_id=sightings.ranger_id) as com  on species.species_id=com.species_id
ORDER BY sighting_time DESC LIMIT 2;


-- task *************************->7
UPDATE  species
SET conservation_status ='Historic'
WHERE  (SELECT extract (year from discovery_date::DATE)
) < 1800;
-- SELECT * FROM species;

-- task *************************->8

SELECT 
  sightings_id,
  CASE 
    WHEN EXTRACT(HOUR FROM sighting_time) BETWEEN 5 AND 11 THEN 'Morning'
    WHEN EXTRACT(HOUR FROM sighting_time) BETWEEN 12 AND 16 THEN 'Afternoon'
    WHEN EXTRACT(HOUR FROM sighting_time) BETWEEN 17 AND 20 THEN 'Evening'
    ELSE 'Night'
  END AS time_of_day
FROM sightings;


-- SELECT * from sightings;
-- SELECT * from rangers;

-- task *************************->9

-- DELETE from rangers
--  where name != (
--  select name from rangers
--  full JOIN (select * from species
-- join sightings  on species.species_id=sightings.species_id) as com  on rangers.ranger_id=com.ranger_id 
-- where sighting_time is NULL) ;

DELETE from rangers
 where name =(select name from rangers
 full JOIN (select * from species
join sightings  on species.species_id=sightings.species_id) as com  on rangers.ranger_id=com.ranger_id 
where sighting_time is NULL);



