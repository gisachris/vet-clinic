INSERT INTO animals (name,date_of_birth,escape_attempts,neutered,weight_kg) 
VALUES ('Agumon','2020-02-03',0,TRUE,10.23),
       ('Gabumon','2018-11-15',2,TRUE,8),
       ('Pickachu','2021-01-07',1,FALSE,15.04),
       ('Devimon','2017-05-12',5,TRUE,11.00);
       /*        secondary insertions        */
       ('Plantmon','2021-11-15',2,FALSE,-5),
       ('Squirtle','1993-04-02',3,TRUE,-12.13),
       ('Angemon','2005-06-12',1,TRUE,-45.00),
       ('Boarmon','2005-06-07',7,TRUE,20.00),
       ('Blossom','1998-10-13',3,TRUE,17.00),
       ('Ditto','2022-05-14',4,TRUE,22.00);


INSERT INTO owners (full_name,age) 
VALUES ('sam smith',34),
       ('jennifer orwell',19),
       ('bob',45),
       ('melody pond',77),
       ('dean wincester',14),
       ('jodie whittaker',38);


INSERT INTO species(name) 
VALUES  ('pokemon'),  
        ('Digimon');


/*Modify your inserted animals so it includes the species_id value*/
UPDATE animals SET species_id = 2 WHERE name LIKE '%mon';
UPDATE animals SET species_id = 1 WHERE species_id IS NULL;

/*Modify your inserted animals to include owner information (owner_id)*/
UPDATE animals SET owner_id = 1 WHERE name = 'Agumon';
UPDATE animals SET owner_id = 2 WHERE name = 'Gabumon' OR name = 'Pickachu';
UPDATE animals SET owner_id = 3 WHERE name = 'Devimon' OR name = 'Plantmon';
UPDATE animals
SET owner_id = 4 WHERE name = 'Charmander' OR name = 'Squirtle' OR name = 'Blossom';
UPDATE animals SET owner_id = 5 WHERE name = 'Angemon' OR name = 'Boarmon';

INSERT INTO vets(name,age,date_of_graduation)
VALUES('william tacher',45,'2000-04-23'),
      ('maisy smith',26,'2019-01-17'),
      ('stephanie mendez',64,'1981-05-04'),
      ('jack harkness',38,'2008-06-08');

INSERT INTO specializations(species_id,vets_id)
VALUES(1,1),
      (2,3),
      (1,3),
      (2,4);

INSERT INTO visits(animals_id,vets_id,date_of_visit)
VALUES(1,1,'2020-05-24'),
      (1,3,'2020-07-22'),
      (2,4,'2021-02-02'),
      (3,2,'2020-01-05'),
      (3,2,'2020-03-08'),
      (3,2,'2020-05-14'),
      (4,3,'2021-05-04'),
      (5,4,'2021-02-24'),
      (6,2,'2019-12-21'),
      (6,1,'2020-08-10'),
      (6,2,'2021-04-07'),
      (7,3,'2019-09-29'),
      (8,4,'2020-08-03'),
      (8,4,'2020-11-04'),
      (9,2,'2019-01-24'),
      (9,2,'2019-05-15'),
      (9,2,'2020-02-27'),
      (9,2,'2020-08-03'),
      (10,3,'2020-05-24'),
      (10,1,'2021-01-11');

INSERT INTO owners (full_name, email) SELECT 'Owner ' || generate_series(1,2500000), 'owner_' || generate_series(1,2500000) || '@mail.com';

INSERT INTO visits (animals_id, vets_id, date_of_visit) SELECT * FROM (SELECT id FROM animals) animal_ids, (SELECT id FROM vets) vets_ids, generate_series('1980-01-01'::timestamp, '2021-01-01', '4 hours') visit_timestamp;
