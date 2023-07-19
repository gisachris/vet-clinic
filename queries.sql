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