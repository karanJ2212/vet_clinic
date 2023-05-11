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
