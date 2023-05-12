/* Database schema to keep the structure of entire database. */

CREATE DATABASE vet_clinic;


CREATE TABLE animals (
  id INTEGER NOT NULL PRIMARY KEY,
  name VARCHAR(255),
  date_of_birth DATE,
  escape_attempts INTEGER,
  neutered BOOLEAN,
  weight_kg DECIMAL(10, 2)
);

ALTER TABLE animals ADD COLUMN species VARCHAR(255);

CREATE TABLE OWNERS(ID SERIAL PRIMARY KEY,full_name VARCHAR(200),AGE INT);

CREATE TABLE species (
    id SERIAL PRIMARY KEY,
    name VARCHAR
);
-- Remove the existing "species" column
ALTER TABLE animals
DROP COLUMN species;

-- Add the "species_id" column as a foreign key referencing the "species" table
ALTER TABLE animals
ADD COLUMN species_id INTEGER;

ALTER TABLE animals
ADD CONSTRAINT fk_species_id
FOREIGN KEY (species_id) REFERENCES species(id);

-- Add the "owner_id" column as a foreign key referencing the "owners" table
ALTER TABLE animals
ADD COLUMN owner_id INTEGER;

ALTER TABLE animals
ADD CONSTRAINT fk_owner_id
FOREIGN KEY (owner_id) REFERENCES owners(id);

CREATE TABLE vets (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  age INTEGER,
  date_of_graduation DATE
);

