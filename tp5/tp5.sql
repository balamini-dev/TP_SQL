#1
CREATE DATABASE IF NOT EXISTS tp5;

use tp5;

CREATE TABLE etudiant
  ( 
  	numero_etudiant int (7) PRIMARY KEY AUTO_INCREMENT,  
  	nom varchar(50), 
  	prenom varchar(50)
  )engine=innodb;

CREATE TABLE ue
  ( 
  	code int (7) PRIMARY KEY,  
  	libelle varchar(50), 
  	nb_heures int(10)
  )engine=innodb;

CREATE TABLE adresse
  (
  	id_adresse int (7) PRIMARY KEY AUTO_INCREMENT, 
  	numero int(7), 
  	ext varchar(10), 
  	rue varchar(50), 
  	code_postal int(5), 
  	ville varchar(50)
  )engine=innodb;

CREATE TABLE enseignant
  (
  	numero_enseignant int (7) PRIMARY KEY AUTO_INCREMENT,
  	nom varchar(50), 
  	prenom varchar(50),
  	age int(3),
  	nb_heures_enseigne int(10), 
  	ville_de_domicile varchar(50)
  )engine=innodb;

CREATE TABLE etudiantUe
  (
  	numero_etudiant int (7),
  	code int (7),
  	noteCC int(2),
	noteExamens int(2)
  )engine=innodb;

#2
# definition de la clé primaire sur plusieurs attributs (couple)
ALTER TABLE etudiantUe ADD PRIMARY KEY (`numero_etudiant`, `code`);

# ajout des contraintes clé étrangère 
ALTER TABLE etudiantUe
    ADD CONSTRAINT fk_numEtudiant_code Foreign key (code) references ue(code);

ALTER TABLE etudiantUe
    ADD CONSTRAINT fk_numero_etudiant Foreign key (numero_etudiant) references etudiant(numero_etudiant);

ALTER TABLE etudiant
ADD 
(
	id_adresse int(7)
);

ALTER TABLE etudiant
    ADD CONSTRAINT fk_id_adresse Foreign key (id_adresse) references adresse(id_adresse);

ALTER TABLE ue
ADD 
(
	id_numero_enseignant int(7)
);

#3
ALTER TABLE ue
    ADD CONSTRAINT fk_id_numero_enseignant Foreign key (id_numero_enseignant) references enseignant(numero_enseignant);


INSERT INTO adresse(id_adresse, numero, ext, rue, code_postal, ville)
 VALUES
 (1, 3, 'b', "Jean médecin", "06000", "Nice"),
 (2, 10, ' ', "Barla", "06000", "Nice"),
 (3, 10, ' ', "Jean Jaures", "06200", "Cagnes");

INSERT INTO etudiant(numero_etudiant, nom, prenom, id_adresse)
 VALUES
 (1001, "Nom1", "prenom1", 1),
 (1002, "Nom2", "prenom2", 2),
 (1003, "Nom3", "prenom3", 3);

INSERT INTO enseignant(numero_enseignant, nom, prenom, age, nb_heures_enseigne, ville_de_domicile)
 VALUES
 (1, "Menez", "Gilles", 25, 35, "Antibes"),
 (2, "Lahire", "Philippe", 26, 30, "Nice"),
 (3, "Kounalis", "Emanuel", 27 , 28, "Nice"),
 (4, "Renevier", "Philippe", 21, 28, "Nice");


INSERT INTO ue(code, libelle, nb_heures, id_numero_enseignant)
 VALUES
(122, "Base de Données", 24, 2),
(959, "Programmation impérative", 36, 1), 
(759, "Algorithmique", 32, 3),
(201, "Programmation WEB", 26, 4);


INSERT INTO etudiantUe(numero_etudiant, code, noteCC, noteExamens)
 VALUES
(1001, 122, 10, 11),
(1001, 959, 8, 10),
(1002, 122, 10, 11),
(1002, 959, 8, 10),
(1003, 122, 10, 11),
(1003, 959, 8, 10),
(1003, 201, 12, 13); 

#4
SELECT numero, ext, rue, ville FROM adresse;
SELECT nom, prenom FROM etudiant;
SELECT libelle, id_numero_enseignant FROM ue;
SELECT code_postal, ville FROM adresse;

SELECT * FROM etudiant WHERE nom = 'Nom1';
SELECT numero_etudiant FROM etudiantue WHERE code = 122;
SELECT * FROM enseignant WHERE prenom = 'Philippe';
SELECT rue FROM adresse WHERE ville = 'Nice';

#5.1
SELECT DISTINCT nom, prenom FROM etudiant INNER JOIN etudiantue on etudiantue.code = 122 or etudiantue.code = 201;

#5.2
SELECT DISTINCT e.nom, e.prenom, ue.libelle FROM etudiant e INNER JOIN ue ue on ue.code=959;

#5.3
SELECT DISTINCT e.prenom, a.rue FROM etudiant e INNER JOIN adresse a on nom = 'Nom1';

#5.4
SELECT DISTINCT nom FROM enseignant # affichage des nom
INNER JOIN ue ON ue.id_numero_enseignant=enseignant.numero_enseignant # lien entre les tables par le champs 'id_numero_enseignant' de la table 'ue' et le champs 'numero_enseignant' de la table 'enseignant'
WHERE ue.code = 201; # la condition

#  5.5 pas fait (à finaliser pour afficher le libellé également)
SELECT DISTINCT etudiant.nom, ue.libelle, etudiantUe.noteCC
FROM etudiant
INNER JOIN etudiantue ON etudiantUe.numero_etudiant=etudiant.numero_etudiant
INNER JOIN ue ON etudiantUe.code=ue.code

# 5.6 on ajoute à la requete ceci :
SELECT DISTINCT etudiant.nom, ue.libelle, etudiantUe.noteCC
FROM etudiant
INNER JOIN etudiantue ON etudiantUe.numero_etudiant=etudiant.numero_etudiant
INNER JOIN ue ON etudiantUe.code=ue.code
WHERE etudiant.nom LIKE 'NOM%'

#6.1
UPDATE etudiantUe set noteCC = noteCC +1

#6.2
UPDATE etudiantUe set noteCC = noteCC +1 WHERE code = 122

#7.1
ALTER TABLE adresse
MODIFY ville varchar(55);

#7.2
ALTER TABLE etudiant
ADD 
(
  age INT(3)
);

#7.3
UPDATE etudiant set age = 52 WHERE numero_etudiant = 1001;
UPDATE etudiant set age = 48 WHERE numero_etudiant = 1002;
UPDATE etudiant set age = 21 WHERE numero_etudiant = 1003;

ALTER TABLE etudiant
DROP age;

###############################################################################################################################
# droits d'acces / privileges
grant ALL PRIVILEGES on tp5.* to admin@localhost identified by 'admin'
grant SELECT, CREATE, UPDATE  on tp5.* to developpeur@localhost identified by 'developpeur'
grant DELETE, DROP  on tp5.* to dba@localhost identified by 'dba'

revoke UPDATE on tp5.* FROM dba@localhost;

DROP USER dba@localhost;
###############################################################################################################################