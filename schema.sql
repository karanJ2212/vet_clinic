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
