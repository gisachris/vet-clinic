CREATE TABLE animals(
    id INT GENERATED ALWAYS AS IDENTITY NOT NULL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    date_of_birth DATE,
    escape_attempts INT,
    neutered BOOLEAN,
    weight_kg DECIMAL(18,2),
    species VARCHAR
);

/*Remove column species*/
ALTER TABLE animals DROP species;

/*Add column species_id which is a foreign key referencing species table*/
ALTER TABLE animals ADD COLUMN species_id INT;
ALTER TABLE animals ADD 
CONSTRAINT SP_FKEY FOREIGN KEY(species_id) REFERENCES species(id);

/*Add column owner_id which is a foreign key referencing the owners table*/
ALTER TABLE animals ADD COLUMN owner_id INT;
ALTER TABLE animals ADD 
CONSTRAINT OW_FKEY FOREIGN KEY (owner_id) REFERENCES owners(id);

CREATE TABLE owners (
id INT NOT NULL PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
full_name VARCHAR(150),
age INT
);

CREATE TABLE species(
id INT NOT NULL PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
name VARCHAR(150)
);