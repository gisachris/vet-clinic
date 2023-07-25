/*Query that selects all animals whose name ends in "mon"*/
SELECT * FROM animals WHERE name LIKE '%mon';

/*Query that selects the name of all animals born between 2016 and 2019*/
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';

/*Query that selects name of all animals that are neutered and have less than 3 escape attempts.*/
SELECT name FROM animals WHERE neutered=TRUE AND escape_attempts<3;

/*Query that selects date of birth of all animals named either "Agumon" or "Pikachu"*/
SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pickachu';

/*Query that selects name and escape attempts of animals that weigh more than 10.5kg*/
SELECT name,escape_attempts FROM animals WHERE weight_kg > 10.5;

/*Query that selects all animals that are neutered*/
SELECT * FROM animals WHERE neutered = TRUE;

/*Query that selects all animals not named Gabumon*/
SELECT * FROM animals WHERE name <> 'Gabumon';

/*Query that selects all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg*/
SELECT * FROM animals WHERE (weight_kg >= 10.4 AND weight_kg <= 17.3);

/*Transaction to change species and Rollback*/
BEGIN TRANSACTION;
UPDATE animals SET species = 'unspecified';
ROLLBACK;

/*Transaction to add species and commit*/
BEGIN TRANSACTION;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
COMMIT;

/*Transaction to Delete and Restore Table data*/
BEGIN TRANSACTION;
DELETE FROM animals;
ROLLBACK;

/*Transaction to update weight fpr negative weights*/
BEGIN TRANSACTION;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT sp1;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO sp1;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;

/*queries to answer Analytical questions*/

/*Query to check how many animals are there*/
SELECT COUNT(*) FROM animals;

/*Query to check total animals with no escape attempts*/
SELECT COUNT(*) FROM animals WHERE escape_attempts <=0;

/*Query to check for the average weight of the animals*/
SELECT AVG(weight_kg) FROM animals;


/*Query to check between the neutered and un neutered animals escape totals*/
SELECT neutered, SUM(escape_attempts) AS total_escapes FROM animals
GROUP BY neutered ORDER BY total_escapes DESC LIMIT 1;

/*Query to check min and max weights for all animal species*/
SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals
GROUP BY species;

/*Query to check  the average number of escape attempts per animal type of those born between 1990 and 2000*/
SELECT species, AVG(escape_attempts) FROM animals
WHERE date_of_birth >= '1990-01-01' AND date_of_birth <= '2000-12-31'
GROUP BY species;

/*Query to check What animals belong to Melody Pond Using JOIN*/
SELECT * FROM animals
INNER JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name = 'melody pond';

/*Query to check What animals belong to the Pokemon species Using JOIN*/
SELECT * FROM animals
INNER JOIN species ON animals.species_id = species.id
WHERE species.name = 'pokemon';

/*Query to check list animals and there owners as well as owners without animals Using JOIN*/
SELECT full_name,name FROM owners
LEFT JOIN animals ON owners.id = animals.owner_id;

/*Query to check How many animals are there per species Using JOIN*/
SELECT species.name, COUNT(*) AS tot_animals FROM animals
INNER JOIN species ON animals.species_id = species.id
GROUP BY species.name;

/*Query to check List all Digimon owned by Jennifer Orwell Using JOIN*/
SELECT owners.full_name,animals.name AS animalname FROM animals
INNER JOIN owners ON animals.owner_id = owners.id
INNER JOIN species ON animals.species_id = species.id
WHERE species.name = 'Digimon' AND owners.full_name = 'jennifer orwell';

/*Query to check List all animals owned by Dean Winchester that haven't tried to escape Using JOIN*/
SELECT name FROM animals
INNER JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name = 'dean wincester' AND animals.escape_attempts <= 0;

/*Query to check Who owns the most animals Using JOIN*/
SELECT owners.full_name,COUNT(*) from animals
INNER JOIN owners ON animals.owner_id = owners.id
GROUP BY owners.full_name ORDER BY COUNT(*) DESC
LIMIT 1;

/*Query to check Who was the last animal seen by William Tatcher?*/
SELECT animals.id,animals.name,date_of_visit FROM animals
INNER JOIN visits ON animals.id = visits.animals_id
INNER JOIN vets ON vets.id = visits.vets_id
WHERE vets.name = 'william tacher'
ORDER BY visits.date_of_visit DESC
LIMIT 1;

/*Query to check How many different animals did Stephanie Mendez see*/
SELECT animals.id,animals.name FROM animals
INNER JOIN visits ON animals.id = visits.animals_id
INNER JOIN vets ON visits.vets_id = vets.id
WHERE vets.name = 'stephanie mendez';

/*Query to check List all vets and their specialties, including vets with no specialties*/
SELECT vets.id, vets.name, species.name
FROM vets
LEFT JOIN specializations ON vets.id = specializations.vets_id
LEFT JOIN species ON specializations.species_id = species.id;

/*Query to check List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020*/
SELECT animals.id,animals.name FROM animals
INNER JOIN visits ON animals.id = visits.animals_id
INNER JOIN vets ON visits.vets_id = vets.id
WHERE vets.name = 'stephanie mendez' AND
visits.date_of_visit BETWEEN '2020-04-01' AND '2020-08-30';

/*Query to check What animal has the most visits to vets*/
SELECT animals.id,animals.name,COUNT(visits.animals_id) FROM animals
INNER JOIN visits ON animals.id = visits.animals_id
GROUP BY animals.id
ORDER BY COUNT(visits.animals_id) DESC
LIMIT 1;

/*Query to check Who was Maisy Smith's first visit*/
 SELECT animals.id,animals.name,visits.date_of_visit FROM animals
INNER JOIN visits ON animals.id = visits.animals_id
INNER JOIN vets ON vets.id = visits.vets_id
WHERE vets.name = 'maisy smith'
ORDER BY visits.date_of_visit ASC
LIMIT 1;

/*Query to check Details for most recent visit: animal information, vet information, and date of visit*/
SELECT animals.id,animals.name,animals.weight_kg,vets.name,visits.date_of_visit FROM animals
INNER JOIN visits ON animals.id = visits.animals_id
INNER JOIN vets ON vets.id = visits.vets_id;
ORDER BY visits.date_of_visit DESC
LIMIT 1;

/*Query to check How many visits were with a vet that did not specialize in that animal's species?*/
SELECT vets.name, COUNT(*) AS total_visits FROM visits
INNER JOIN animals ON visits.animals_id = animals.id
INNER JOIN vets ON visits.vets_id = vets.id
LEFT JOIN specializations 
ON animals.species_id = specializations.species_id 
AND specializations.vets_id = vets.id
WHERE specializations.species_id IS NULL
GROUP BY vets.name;

/*Query to check What specialty should Maisy Smith consider getting? Look for the species she gets the most*/
SELECT species.name AS specialty, COUNT(*) AS species_count FROM visits
INNER JOIN animals ON visits.animals_id = animals.id
INNER JOIN vets ON visits.vets_id = vets.id
INNER JOIN species ON animals.species_id = species.id
WHERE vets.name = 'maisy smith'
GROUP BY species.name
ORDER BY species_count DESC
LIMIT 1;

/*Querry to run Aggregate function to count all visits to animal with id 4*/
SELECT COUNT(*) FROM visits where animal_id = 4;

/*Querry to select all FROM visits where the vets_id = 2*/
SELECT * FROM visits where vet_id = 2;

/*Querry to select all FROM owners where the email is given below*/
SELECT * FROM owners where email = 'owner_18327@mail.com';