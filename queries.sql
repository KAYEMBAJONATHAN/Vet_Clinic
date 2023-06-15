select * FROM animals where Name like '%mon';
SELECT * FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT * FROM animals WHERE (neutered = true) AND (escape_attempts < 3);
SELECT date_of_birth FROM animals WHERE NAME IN ( 'Agumon','Pikachu');
SELECT name, escape_attempts FROM animals WHERE (weight_kg > 10.5);
SELECT * FROM animals WHERE (neutered = true);
SELECT * FROM animals WHERE name NOT IN ('Gabumon');
SELECT * FROM animals WHERE (weight_kg >= 10.4 AND weight_kg <= 17.3);

BEGIN;
UPDATE animals SET species = 'unspecified';
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

BEGIN;
UPDATE animals SET species = 'digimon' WHERE Name like '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
ROLLBACK;
SELECT * FROM animals;
BEGIN;
DELETE FROM animals;
ROLLBACK;
SELECT * FROM animals;

BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT date_deletion;
UPDATE animals SET weight_kg = weight_kg * (-1);
ROLLBACK date_deletion;
UPDATE animals SET weight_kg = weight_kg * (-1) WHERE (weight_kg < 0);
COMMIT;

SELECT COUNT(*) FROM animals;
SELECT COUNT(*) FROM animals WHERE (escape_attempts = 0);
SELECT AVG(weight_kg)  FROM animals;
SELECT neutered,AVG(escape_attempts) AS escape FROM animals GROUP BY (neutered) ORDER BY escape DESC LIMIT 1;
SELECT MIN(weight_kg),MAX(weight_kg), species FROM animals GROUP BY species;
SELECT species,AVG(escape_attempts) AS escape FROM animals WHERE date_of_birth BETWEEN  '1990-01-01' AND '2000-01-01' GROUP BY (species);

SELECT animals.name, owners.full_name FROM animals JOIN owners ON animals.owners_id=owners.id WHERE full_name = 'Melody Pond';
SELECT animals.name, species.name FROM animals JOIN species ON animals.species_id=species.id WHERE species.name = 'Pokemon';
SELECT owners.full_name, animals.name AS animal_name FROM owners LEFT JOIN animals ON owners.id=animals.owners_id;
SELECT species.name, COUNT(*) AS species_number FROM species JOIN animals ON species.id = animals.species_id GROUP BY species.name;
SELECT name AS digimon_animals, owners.full_name FROM (SELECT animals.name, animals.owners_id FROM animals JOIN SPECIES ON species_id = species.id WHERE species.name LIKE 'Digimon') AS all_digimons JOIN owners ON all_digimons.owners_id = owners.id WHERE owners.full_name LIKE 'Jennifer Orwell';
SELECT animals.name FROM animals JOIN owners ON animals.owners_id=owners.id WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts<1;
SELECT owners.full_name, COUNT(animals.name) AS all_animals from animals JOIN owners ON animals.owners_id = owners.id GROUP BY owners.full_name ORDER BY all_animals DESC LIMIT 1;