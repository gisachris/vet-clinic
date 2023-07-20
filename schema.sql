CREATE TABLE animals(
    id INT GENERATED ALWAYS AS IDENTITY NOT NULL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    date_of_birth DATE,
    escape_attempts INT,
    neutered BOOLEAN,
    weight_kg DECIMAL(18,2),
    species_id INT FOREIGN KEY,
    owners_id INT FOREIGN KEY
);

CREATE TABLE owners (
id INT NOT NULL PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
full_name VARCHAR(150),
age INT
);

CREATE TABLE species(
id INT NOT NULL PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
name VARCHAR(150)
);