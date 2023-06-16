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

SELECT animals.name FROM animals
JOIN visits ON animals.id = visits.animal_id
JOIN vets ON visits.vet_id = vets.id
WHERE vets.name = 'William Tatcher'
ORDER BY visits.visit_date DESC LIMIT 1;

SELECT COUNT(DISTINCT animals.name) AS animal_count from animals
JOIN visits ON animals.id = visits.animal_id
JOIN vets ON visits.vet_id = vets.id
WHERE vets.name = 'Stephanie Mendez';

SELECT vets.name as Vet_Name , species.name as specialized_in FROM vets 
LEFT JOIN specializations ON vets.id = specializations.vet_id
LEFT JOIN species ON specializations.species_id = species.id;

SELECT animals.name from animals
JOIN visits ON animals.id = visits.animal_id
JOIN vets ON visits.vet_id = vets.id
WHERE vets.name = 'Stephanie Mendez'
AND visits.visit_date >= '2020-04-01'
AND visits.visit_date <= '2020-08-30';

SELECT animals.name AS Animal_Name, COUNT(visits.animal_id) AS Visit_Count FROM animals
JOIN visits ON animals.id = visits.animal_id
GROUP BY animals.name ORDER BY visit_count DESC LIMIT 1;

SELECT animals.name AS Animal_Name from animals
JOIN visits ON animals.id = visits.animal_id
JOIN vets ON visits.vet_id = vets.id
JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name = 'Maisy Smith'
ORDER BY visits.visit_date ASC LIMIT 1;

SELECT animals.name AS Animal_Name, vets.name AS Checked_by, visits.visit_date FROM animals
JOIN visits ON animals.id = visits.animal_id
JOIN vets ON visits.vet_id = vets.id
ORDER BY visits.visit_date DESC LIMIT 1;

SELECT COUNT(*) AS visit_count
FROM visits v
JOIN vets ve ON ve.id = v.vet_id
JOIN animals a ON a.id = v.animal_id
LEFT JOIN specializations s ON s.vet_id = ve.id AND s.species_id = a.species_id
WHERE s.vet_id IS NULL OR s.species_id IS NULL;

SELECT species.name AS species, COUNT(species.id) AS visit_count
FROM vets
JOIN visits ON vets.id = visits.vet_id
JOIN animals ON animals.id = visits.animal_id
JOIN species ON species.id = animals.species_id
WHERE vets.name = 'Maisy Smith'
GROUP BY species.id
ORDER BY visit_count DESC
LIMIT 1;