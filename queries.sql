/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name like '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' and '2019-12-31';
SELECT name FROM animals WHERE neutered=true and escape_attempts<3;
SELECT date_of_birth FROM animals WHERE name IN ('Agumon','Pikachu');
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered=true;
SELECT * FROM animals WHERE name <> 'Gabumon';
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

BEGIN;

UPDATE animals
SET species = 'unspecified';

SELECT * FROM animals; -- Verify the change

ROLLBACK;

SELECT * FROM animals; -- Verify the rollback

BEGIN;

UPDATE animals
SET species = 'digimon'
WHERE name LIKE '%mon';

UPDATE animals
SET species = 'pokemon'
WHERE species IS NULL or species = '';

SELECT * FROM animals; -- Verify the changes

COMMIT;

SELECT * FROM animals; -- Verify changes persist after commit

BEGIN;

DELETE FROM animals;

SELECT * FROM animals; -- Verify the deletion (should return no records)

ROLLBACK;

SELECT * FROM animals; -- Verify records still exist after the rollback

BEGIN;

-- Delete animals born after Jan 1st, 2022
DELETE FROM animals
WHERE date_of_birth > '2022-01-01';

-- Create a savepoint
SAVEPOINT my_savepoint;

-- Update all animals' weights to be their weight multiplied by -1
UPDATE animals
SET weight_kg = weight_kg * -1;

-- Rollback to the savepoint
ROLLBACK TO my_savepoint;

-- Update negative weights to be their weight multiplied by -1
UPDATE animals
SET weight_kg = weight_kg * -1
WHERE weight_kg < 0;

-- Commit the transaction
COMMIT;

vet_clinic=# SELECT COUNT(*) FROM animals;
vet_clinic=# SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;
vet_clinic=# SELECT AVG(weight_kg) FROM animals;
SELECT neutered ,SUM(escape_attempts) AS total_escape_attempts from animals GROUP BY neutered ORDER BY total_escape_attempts DESC;
select species, max(weight_kg) as max_weight ,min(weight_kg) as min_weight from animals group by species;

SELECT species, AVG(escape_attempts) AS average_escape_attempts FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;


SELECT a.name
FROM animals a
JOIN owners o ON a.owner_id = o.id
WHERE o.full_name = 'Melody Pond';


SELECT a.name
FROM animals a
JOIN species s ON a.species_id = s.id
WHERE s.name = 'Pokemon';

SELECT o.full_name, a.name
FROM owners o
LEFT JOIN animals a ON o.id = a.owner_id
ORDER BY o.full_name;


SELECT s.name, COUNT(*) AS animal_count
FROM species s
JOIN animals a ON s.id = a.species_id
GROUP BY s.name;


SELECT a.name
FROM animals a
JOIN owners o ON a.owner_id = o.id
JOIN species s ON a.species_id = s.id
WHERE o.full_name = 'Jennifer Orwell' AND s.name = 'Digimon';


SELECT a.name
FROM animals a
JOIN owners o ON a.owner_id = o.id
LEFT JOIN escapelog e ON a.id = e.animal_id
WHERE o.full_name = 'Dean Winchester' AND e.animal_id IS NULL;


SELECT o.full_name, COUNT(*) AS animal_count
FROM owners o
JOIN animals a ON o.id = a.owner_id
GROUP BY o.full_name
ORDER BY COUNT(*) DESC
LIMIT 1;

SELECT a.name AS animal_name
FROM animals AS a
INNER JOIN visits AS v ON a.id = v.animal_id
WHERE v.vet_id = (SELECT id FROM vets WHERE name = 'William Tatcher')
ORDER BY v.visit_date DESC
LIMIT 1;
--
SELECT COUNT(DISTINCT v.animal_id) AS animal_count
FROM visits AS v
WHERE v.vet_id = (SELECT id FROM vets WHERE name = 'Stephanie Mendez');
--
SELECT v.name AS vet_name, s.name AS specialty_name
FROM vets AS v
LEFT JOIN specializations AS sp ON v.id = sp.vet_id
LEFT JOIN species AS s ON sp.species_id = s.id;
--
SELECT a.name AS animal_name
FROM animals AS a
INNER JOIN visits AS v ON a.id = v.animal_id
INNER JOIN vets AS ve ON v.vet_id = ve.id
WHERE ve.name = 'Stephanie Mendez'
  AND v.visit_date >= DATE '2020-04-01'
  AND v.visit_date <= DATE '2020-08-30';

--
SELECT a.name AS animal_name, COUNT(*) AS visit_count
FROM animals AS a
INNER JOIN visits AS v ON a.id = v.animal_id
GROUP BY a.name
ORDER BY visit_count DESC
LIMIT 1;

--
SELECT a.name AS animal_name
FROM animals AS a
INNER JOIN visits AS v ON a.id = v.animal_id
INNER JOIN vets AS ve ON v.vet_id = ve.id
WHERE ve.name = 'Maisy Smith'
ORDER BY v.visit_date ASC
LIMIT 1;
--
SELECT a.name AS animal_name, v.visit_date, ve.name AS vet_name, ve.age AS vet_age
FROM animals AS a
INNER JOIN visits AS v ON a.id = v.animal_id
INNER JOIN vets AS ve ON v.vet_id = ve.id
ORDER BY v.visit_date DESC
LIMIT 1;

--
SELECT COUNT(*) AS mismatched_visits
FROM visits AS v
INNER JOIN animals AS a ON v.animal_id = a.id
INNER JOIN vets AS ve ON v.vet_id = ve.id
LEFT JOIN specializations AS sp ON ve.id = sp.vet_id AND a.species_id = sp.species_id
WHERE sp.vet_id IS NULL;
--
select v.name as vet_name , s.name as specie_name, count(*) as total_visits from vets as v 
inner join visits on v.id = visits.vet_id
inner join animals as a on a.id= visits.animal_id inner join  species as s 
on a.species_id = s.id  where v.name =  'Maisy Smith' group by vet_name,s.name 
ORDER BY total_visits DESC

