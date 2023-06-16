INSERT INTO animals (id,name,date_of_birth,escape_attempts,neutered,weight_kg) 
 VALUES (1,'Agumon', date '2020-02-03', 0, true ,10.23),
        (2,'Gabumon', date '2018-11-15', 2, true, 8.00), 
        (3,'Pikachu', date '2021-01-07', 1, false, 15.04), 
        (4,'Devimon', date '2017-05-12', 5, true, 11.00);
        (5,'Charmander', '2020-02-08', 0, false, -11), 
        (6,'Plantmon', '2021-11-15', 2 , true , -5.7),
        (7,'Squirtle', '1993-04-02', 3 , false , -12.13),
        (8, 'Angemon', '2005-06-12', 1 , true , -45),
        (9,'Boarmon',  '2005-06-07', 7, true , 20.4),
        (10,'Blossom', '1998-10-13', 3 , true , 17),
        (11,'Ditto', '2022-05-14' , 4 , true , 22);

INSERT INTO owners (full_name, age) VALUES ('Sam Smith', 34);
INSERT INTO owners (full_name, age) VALUES ('Jennifer Orwell', 19);
INSERT INTO owners (full_name, age) VALUES ('Bob', 45);
INSERT INTO owners (full_name, age) VALUES ('Melody Pond', 77);
INSERT INTO owners (full_name, age) VALUES ('Dean Winchester', 14);
INSERT INTO owners (full_name, age) VALUES ('Jodie Whittaker', 38);
INSERT INTO species (name) VALUES ('Pokemon');
INSERT INTO species (name) VALUES ('Digimon');
UPDATE animals SET species_id = 2 WHERE name LIKE '%mon';
UPDATE animals SET species_id = 1 WHERE species_id IS NULL;

BEGIN;
UPDATE animals SET owners_id = 1 WHERE name LIKE 'Agumon';
UPDATE animals SET owners_id = 3 WHERE name IN ('Gabumon', 'Pikachu');
UPDATE animals SET owners_id = 4 WHERE name IN ('Devimon', 'Plantmon');
UPDATE animals SET owners_id = 5 WHERE name IN ('Charmander', 'Squirtle', 'Blossom');
UPDATE animals SET owners_id = 6 WHERE name IN ('Angemon', 'Boarmon');
SELECT * FROM animals;