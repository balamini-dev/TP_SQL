CREATE DATABASE IF NOT EXISTS tp4;

use tp4;

CREATE TABLE personne
(
    personne_id int(11) PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(30) NOT NULL,
    prenom VARCHAR(30) NOT NULL
);

CREATE TABLE ingenieur
(
    ingenieur_id int(7) PRIMARY KEY AUTO_INCREMENT,
    ecole VARCHAR(50) NOT NULL,
    adresse VARCHAR(100),
    code_postal VARCHAR(5)
);

# Ajouter un champs à une table exsitante
ALTER TABLE personne ADD ingenieur_id int(7)

# Ajout d'une contrainte qu'on nomme fk_personne_id qui va définir que le champs "ingenieur_id" de la table "personne" sera la clé étrangére qui pointe sur le champs "ingenieur_id" de la table "ingénieur"
ALTER TABLE personne
    ADD CONSTRAINT fk_personne_id Foreign key (ingenieur_id) references ingenieur(ingenieur_id) 

# Insérer des données à une table
 INSERT INTO personne(nom, prenom)
 VALUES
 ('Diaby', 'Balamini', 2),
 ('Toto', 'Tata', 1),
 ('Nana', 'Tomtom', 2);
 ('Nene', 'Pepe', 1)


 INSERT INTO ingenieur(ecole, adresse, code_postal)
 VALUES
 ('IPI', 'République', 75010),
 ('Balzac', 'Paris', 75000),
 ('Pasteur', 'Clichy', 92110),
 ('Jules Ferry', 'Lille', 59000);

# Ajouter plusieur champs à une table exsitante
ALTER TABLE personne
ADD 
(
	adresse VARCHAR(100),
	code_postal int(5),
	numero_telephone int(10),
	date_naissance date
);

ALTER TABLE ingenieur
ADD 
(
	nom_Entreprise VARCHAR(100)
);

# Modifier l'ordre dun champs par rapport à un autre
ALTER TABLE personne
MODIFY COLUMN ingenieur_id int(7) AFTER date_naissance

INSERT INTO personne(ecole, adresse, code_postal)
 VALUES
 ('IPI', 'République', 75010),
 ('Balzac', 'Paris', 75000),
 ('Pasteur', 'Clichy', 92110),
 ('Jules Ferry', 'Lille', 59000);


# Modification de valeurs
UPDATE ingenieur
SET nom_Entreprise = 'google'
WHERE `ingenieur_id` = 1;

UPDATE ingenieur
SET nom_Entreprise = 'amazon'
WHERE `ingenieur_id` = 2;

UPDATE ingenieur
SET nom_Entreprise = 'fnac'
WHERE `ingenieur_id` = 3;

UPDATE ingenieur
SET nom_Entreprise = 'free'
WHERE `ingenieur_id` = 4;


INSERT INTO personne(adresse, code_postal, numero_telephone, date_naissance)
 VALUES
 ('Rue de Paris', 92110, '0123456789', '1993-09-19'),
 ('Rue de Marseille', 13000, '0855555555', '2018-01-15'),
 ('Rue de Lille', 59000, '0666666666', '2018-07-16'),
 ('Rue de la Pepo', 55555, '0666666666', '2018-10-28');


ALTER TABLE personne
CHANGE nom firs_name VARCHAR(50);

ALTER TABLE personne
CHANGE prenom last_name VARCHAR(50);


# jointure entre deux tables, permet d'afficher les deux tables en fonction d'une valeurs communes dans chacune de ces deux tables
SELECT * FROM personne INNER JOIN ingenieur on personne.ingenieur_id = ingenierur.ingenieur_id

