DELIMITER $$
CREATE TRIGGER trigger_produits_n
BEFORE INSERT ON produits

FOR EACH ROW
BEGIN
	INSERT INTO log_produits(nom, prix, type_produits, date_log, action)
    VALUES
    (new.nom, new.prix, new.type_produit, now(), 'INSERT');
END $$


##############################################################################################

DELIMITER $$
CREATE TRIGGER trigger_produits_d
BEFORE DELETE ON produits

FOR EACH ROW
BEGIN
	INSERT INTO log_produits(nom, prix, type_produits, date_log, action)
    VALUES
    (old.nom, old.prix, old.type_produit, now(), 'DELETE');
END $$


##############################################################################################

DELIMITER $$
CREATE TRIGGER trigger_produits_u
BEFORE UPDATE ON produits

FOR EACH ROW
BEGIN
	INSERT INTO log_produits(nom, prix, type_produits, date_log, action)
    VALUES
    (old.nom, old.prix, old.type_produit, now(), 'UPDATE');
END $$

------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------


DELIMITER $$
CREATE TRIGGER trigger_place_parking
BEFORE INSERT ON appartement

FOR EACH ROW
BEGIN
	IF NEW.placeParking = 0 THEN
	SET NEW.prixParking = NULL;
    END IF;
END $$


------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------


DELIMITER $$
CREATE TRIGGER trigger_superficie_3
BEFORE INSERT ON appartement

FOR EACH ROW
BEGIN
	IF NEW.num = (SELECT appartement FROM piece)THEN
	SET NEW.superficie = (SELECT superficie FROM piece);
    END IF;
END $$

------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------

DELIMITER $$
CREATE TRIGGER trigger_superficie_2
BEFORE INSERT ON piece

FOR EACH ROW
BEGIN
	SET NEW.superficie = sum(NEW.superficie);
END $$