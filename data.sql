/* Populate database with sample data. */

vet_clinic=# INSERT INTO animals (id,name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (1,'Agumon', '2020-02-03', 0, true, 10.23),(2,'Gabumon', '2018-11-15', 2, true, 8.00),(3,'Pikachu', '2021-01-07', 1, false, 15.04),(4,'Devimon', '2017-05-12', 5, true, 11.00);

INSERT INTO animals (id,name, date_of_birth, escape_attempts, neutered, weight_kg, species) VALUES (5,'Charmander', '2020-02-08', 0, false, -11, ''),(6,'Plantmon', '2021-11-15', 2, true, -5.7, ''),(7,'Squirtle', '1993-04-02', 3, false, -12.13, ''),(8,'Angemon', '2005-06-12', 1, true, -45, ''),  (9,'Boarmon', '2005-06-07', 7, true, 20.4, ''),  (10,'Blossom', '1998-10-13', 3, true, 17, ''),  (11,'Ditto', '2022-05-14', 4, true, 22, '');

INSERT INTO owners (full_name, age) VALUES
    ('Sam Smith', 34),
    ('Jennifer Orwell', 19),
    ('Bob', 45),
    ('Melody Pond', 77),
    ('Dean Winchester', 14),
    ('Jodie Whittaker', 38);

INSERT INTO species (name) VALUES
    ('Pokemon'),
    ('Digimon');

UPDATE animals
SET species_id = (
    CASE
        WHEN name LIKE '%mon' THEN (SELECT id FROM species WHERE name = 'Digimon')
        ELSE (SELECT id FROM species WHERE name = 'Pokemon')
    END
);

-- Update animals owned by Sam Smith
UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Sam Smith')
WHERE name = 'Agumon';

-- Update animals owned by Jennifer Orwell
UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell')
WHERE name IN ('Gabumon', 'Pikachu');

-- Update animals owned by Bob
UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Bob')
WHERE name IN ('Devimon', 'Plantmon');

-- Update animals owned by Melody Pond
UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Melody Pond')
WHERE name IN ('Charmander', 'Squirtle', 'Blossom');

-- Update animals owned by Dean Winchester
UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Dean Winchester')
WHERE name IN ('Angemon', 'Boarmon');

INSERT INTO vets (name, age, date_of_graduation)
VALUES ('William Tatcher', 45, DATE '2000-04-23');

INSERT INTO vets (name, age, date_of_graduation)
VALUES ('Maisy Smith', 26, DATE '2019-01-17');

INSERT INTO vets (name, age, date_of_graduation)
VALUES ('Stephanie Mendez', 64, DATE '1981-05-04');

INSERT INTO vets (name, age, date_of_graduation)
VALUES ('Jack Harkness', 38, DATE '2008-06-08');

-- Vet William Tatcher is specialized in Pokemon
SELECT id FROM vets WHERE name = 'William Tatcher';

-- Vet Stephanie Mendez is specialized in Digimon and Pokemon
SELECT id FROM vets WHERE name = 'Stephanie Mendez';

-- Vet Jack Harkness is specialized in Digimon
SELECT id FROM vets WHERE name = 'Jack Harkness';

-- Species Pokemon
SELECT id FROM species WHERE name = 'Pokemon';

-- Species Digimon
SELECT id FROM species WHERE name = 'Digimon';

-- Vet William Tatcher: ID = 1
-- Vet Stephanie Mendez: ID = 3
-- Vet Jack Harkness: ID = 4
-- Species Pokemon: ID = 1
-- Species Digimon: ID = 2


-- Vet William Tatcher is specialized in Pokemon
INSERT INTO specializations (vet_id, species_id)
VALUES (1, 1);

-- Vet Stephanie Mendez is specialized in Digimon and Pokemon
INSERT INTO specializations (vet_id, species_id)
VALUES (3, 2), (3, 1);

-- Vet Jack Harkness is specialized in Digimon
INSERT INTO specializations (vet_id, species_id)
VALUES (4, 2);


-- Agumon visited William Tatcher on May 24th, 2020.
SELECT id FROM animals WHERE name = 'Agumon';
SELECT id FROM vets WHERE name = 'William Tatcher';

-- Agumon visited Stephanie Mendez on Jul 22nd, 2020.
SELECT id FROM vets WHERE name = 'Stephanie Mendez';

-- Gabumon visited Jack Harkness on Feb 2nd, 2021.
SELECT id FROM animals WHERE name = 'Gabumon';
SELECT id FROM vets WHERE name = 'Jack Harkness';

-- Pikachu visited Maisy Smith on Jan 5th, 2020.
SELECT id FROM animals WHERE name = 'Pikachu';
SELECT id FROM vets WHERE name = 'Maisy Smith';

-- Pikachu visited Maisy Smith on Mar 8th, 2020.
-- Pikachu visited Maisy Smith on May 14th, 2020.
-- Additional visits for Pikachu and Maisy Smith will be handled together later.

-- Devimon visited Stephanie Mendez on May 4th, 2021.
SELECT id FROM animals WHERE name = 'Devimon';

-- Charmander visited Jack Harkness on Feb 24th, 2021.
SELECT id FROM animals WHERE name = 'Charmander';

-- Plantmon visited Maisy Smith on Dec 21st, 2019.
SELECT id FROM animals WHERE name = 'Plantmon';

-- Plantmon visited William Tatcher on Aug 10th, 2020.
SELECT id FROM vets WHERE name = 'William Tatcher';

-- Plantmon visited Maisy Smith on Apr 7th, 2021.
-- Additional visit for Plantmon and Maisy Smith will be handled later.

-- Squirtle visited Stephanie Mendez on Sep 29th, 2019.
SELECT id FROM animals WHERE name = 'Squirtle';

-- Angemon visited Jack Harkness on Oct 3rd, 2020.
SELECT id FROM animals WHERE name = 'Angemon';

-- Boarmon visited Maisy Smith on Jan 24th, 2019.
SELECT id FROM animals WHERE name = 'Boarmon';

-- Blossom visited Stephanie Mendez on May 24th, 2020.
SELECT id FROM animals WHERE name = 'Blossom';

-- Blossom visited William Tatcher on Jan 11th, 2021.
SELECT id FROM vets WHERE name = 'William Tatcher';



-- Agumon: ID = 1
-- Gabumon: ID = 2
-- Pikachu: ID = 3
-- Devimon: ID = 4
-- Charmander: ID = 5
-- Plantmon: ID = 6
-- Squirtle: ID = 7
-- Angemon: ID = 8
-- Boarmon: ID = 9
-- Blossom: ID = 10
-- Vet William Tatcher: ID = 1
-- Vet Stephanie Mendez: ID = 3
-- Vet Jack Harkness: ID = 4
-- Vet Maisy Smith: ID = 2

-- Agumon visited William Tatcher on May 24th, 2020.
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES (1, 1, DATE '2020-05-24');

-- Agumon visited Stephanie Mendez on Jul 22nd, 2020.
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES (1, 3, DATE '2020-07-22');

-- Gabumon visited Jack Harkness on Feb 2nd, 2021.
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES (2, 4, DATE '2021-02-02');

-- Pikachu visited Maisy Smith on Jan 5th, 2020.
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES (3, 2, DATE '2020-01-05');

-- Pikachu visited Maisy Smith on Mar 8th, 2020.
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES (3, 2, DATE '2020-03-08');

-- Pikachu visited Maisy Smith on May 14th, 2020.
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES (3, 2, DATE '2020-05-14');

-- Devimon visited Stephanie Mendez on May 4th, 2021.
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES (4, 3, DATE '2021-05-04');

-- Charmander visited Jack Harkness on Feb 24th, 2021.
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES (5, 4, DATE '2021-02-24');

-- Plantmon visited Maisy Smith on Dec 21st, 2019.
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES (6, 2, DATE '2019-12-21');

-- Plantmon visited William Tatcher on Aug 10th, 2020.
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES (6, 1, DATE '2020-08-10');

-- Plantmon visited Maisy Smith on Apr 7th, 2021.
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES (6, 2, DATE '2021-04-07');

-- Squirtle visited Stephanie Mendez on Sep 29th, 2019.
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES (7, 3, DATE '2019-09-29');

-- Angemon visited Jack Harkness on Oct 3rd, 2020.
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES (8, 4, DATE '2020-10-03');

-- Boarmon visited Maisy Smith on Jan 24th, 2019.
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES (9, 2, DATE '2019-01-24');

-- Blossom visited Stephanie Mendez on May 24th, 2020.
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES (10, 3, DATE '2020-05-24');

-- Blossom visited William Tatcher on Jan 11th, 2021.
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES (10, 1, DATE '2021-01-11');

