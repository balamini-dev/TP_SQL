DELIMITER | -- on définit un délimitateur --
CREATE PROCEDURE affiche_produits(IN marque varchar) -- déclaration de la procédure --

BEGIN
	SELECT nom, prix
	FROM produits
	WHERE marque=nom;
END |

CALL affiche_produits('IPHONE');

########################### VARIABLE LOCAL ###################################

DELIMITER | -- on définit un délimitateur -- 
CREATE PROCEDURE affiche_produits(IN marque varchar) -- déclaration de la procédure --

BEGIN
    DECLARE num_produit INT DEFAULT 0;
    
    SET @num_produit = 2; # pour utiliser la variable local on met un @ avant
    
	SELECT nom, prix
	FROM produits
	WHERE nom=marque AND type_produit = @num_produit;
END |

CALL affiche_produits('IPHONE');

######################### 2 PARAMETRES #####################################

CREATE PROCEDURE affiche_produits_2(IN marque varchar(50), OUT v_prix INT(5))

BEGIN 
	SELECT prix INTO v_prix
	FROM produits
	WHERE marque=nom; 
END |

CALL affiche_produits_2('DVD', @v_prix);
SELECT @v_prix

############################### VARIABLE GLOBALE ############################


CREATE PROCEDURE affiche_produits_2(IN marque varchar(50), OUT v_prix INT(5))

BEGIN 
	SELECT prix INTO v_prix
	FROM produits
	WHERE marque=nom; 
END |

SET @v_glo = 'IPHONE';
CALL affiche_produits_2(@v_glo, @v_prix);
SELECT @v_prix

###############################################################################

CREATE PROCEDURE affiche_produits_2(IN marque varchar(50), OUT v_prix INT(5))

BEGIN 
	SELECT prix INTO v_prix
	FROM produits
	WHERE marque=nom; 
END

BEGIN 
	SELECT prix
	FROM produits
	WHERE marque='DVD'; 
END

SET @v_glo = 'IPHONE';
CALL affiche_produits_2(@v_glo, @v_prix);
SELECT @v_prix

###############################################################################

BEGIN   
  BEGIN
	SELECT prix INTO v_prix
	FROM produits
 	WHERE marque=nom
  END;

  BEGIN
	DECLARE num_produit VARCHAR;
    SET @num_produit = 'DVD';
    
	SELECT prix
	FROM produits
	WHERE marque=@num_produit
  END;
END

###############################################################################

INSERT INTO produits(nom, type_produit, prix)
 VALUES
 ("IPHONE", 2, 310),
 ("IPHONE", 2, 320),
 ("IPHONE", 2, 330),
 ("IPHONE", 2, 340);


DELIMITER |
CREATE PROCEDURE affiche_produits_3()

BEGIN
	DECLARE retenu INT;
	SET @retenu = 90;

	SELECT prix FROM produits
	IF prix = 210 OR prix =220 THEN
		SELECT prix FROM produits;

	ELSE SELECT 'Le prix est différent de 210 et 220';

END |



###############################################################


BEGIN
/* Déclaration des variables */
DECLARE v_type_produits INT;
DECLARE var_nom VARCHAR(11);
DECLARE var_prix INT;
DECLARE done INT DEFAULT 0;

/* bloc d'instructions Affichage du prix si nom = 'IPHONE' */
DECLARE c_iphone CURSOR FOR
SELECT nom, prix FROM produits;

	BEGIN
		
	/* Initialisation de variable */
		SET retenu :=90;
		SET v_type_produits :=2;

	/* ouverture du curseur */
	  OPEN c_iphone;

	  	prix_loop:LOOP
	  	FETCH c_iphone INTO var_nom, var prix;
	  	SELECT var_nom, var_prix
	  	END LOOP;
	/* fermeture du curseur */
	  CLOSE c_iphone;

	END; 
END

#############################################################################


BEGIN
    DECLARE var_nom VARCHAR(11);
    DECLARE var_prix INT(11);


    DECLARE c_nom CURSOR FOR
	SELECT nom, prix FROM produits WHERE nom=marque; # ce SELECT permet de selectionner la requete sur laquel sera appliqué le CURSEUR
    BEGIN
		OPEN c_nom;
	    c_loop: LOOP # permet de boucler sur toutes les lignes 
	    FETCH c_nom INTO var_nom, var_prix; # permet de prendre les infos du curseur dans les variables
        SELECT var_nom, var_prix; # ce SELECT permet d'afficher le résultat
    	END LOOP;
		CLOSE c_nom;
	END;
END

##############################################################################

#IPHONE
affiche_produits(IN p_nom VARCHAR(10), OUT p_prix INT)
BEGIN
  DECLARE retenu INT;
  DECLARE v_type_produit INT;
  DECLARE var_nom VARCHAR(11);
  DECLARE var_prix INT;
  DECLARE done INT DEFAULT 0;
  
  /*Bloc Affichage de prix si nom = 'IPHONE'*/
  DECLARE c_iphone CURSOR FOR
  SELECT nom, prix FROM produits;
  
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done=1;
  
  BEGIN
  	/*Initialisation de variables*/
  	SET retenu := 90;
    SET v_type_produit := 2;
    
    OPEN c_iphone;
    	prix_loop: LOOP
        FETCH c_iphone INTO var_nom, var_prix;
        
        	IF (var_prix - retenu) = 210 THEN
            	SELECT '210';
            ELSEIF (var_prix - retenu) = 220 THEN
            	SELECT '220';
        	ELSE
            	SELECT 'prix différent de 210 et 220';
            END IF;
            
            IF done = 1 THEN
            LEAVE prix_loop;
            END IF;
            
        END LOOP;
     CLOSE c_iphone;
  End;
End
####################################################################

#DVD
affiche_produits(IN p_nom VARCHAR(10), OUT p_prix INT)
BEGIN
  DECLARE retenu INT;
  DECLARE v_type_produit INT;
  DECLARE var_nom VARCHAR(11);
  DECLARE var_prix INT;
  DECLARE done INT DEFAULT 0;
  
  /*Bloc Affichage de prix si nom = 'DVD'*/
  DECLARE c_dvd CURSOR FOR
  SELECT nom, prix FROM produits;
  
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done=1;
  
  BEGIN
  	/*Initialisation de variables*/
  	SET retenu := 10;
    SET v_type_produit := 2;
    
    OPEN c_dvd;
    	prix_loop: LOOP
        FETCH c_dvd INTO var_nom, var_prix;
        
        	IF (var_prix - retenu) = 15 THEN
            	SELECT '15';
            ELSEIF (var_prix - retenu) = 25 THEN
            	SELECT '25';
        	ELSE
            	SELECT 'prix différent de 15 et 20';
            END IF;
            
            IF done = 1 THEN
            LEAVE prix_loop;
            END IF;
            
        END LOOP;
     CLOSE c_dvd;
  End;
End


###################################################################

BEGIN
/* déclaration des variables */
DECLARE v_type_produits INT (5);
DECLARE var_nom VARCHAR(11);
DECLARE var_prix INT(5);
DECLARE done INT DEFAULT 0;
DECLARE retenu INT DEFAULT 0;

/* bloc d'instructions Affichage du prix si nom = 'IPHONE' */
DECLARE c_iphone CURSOR FOR
SELECT nom, prix FROM produits;

	BEGIN
		
	/* initialisation de variable */
		SET retenu :=90;
		SET v_type_produits :=2;

	/* ouverture du curseur */
	  OPEN c_iphone;

	  	prix_loop:LOOP
	  	FETCH c_iphone INTO var_nom, var_prix;
        
		IF var_prix - retenu = 210 OR var_prix - retenu=220 THEN
	  		SELECT var_nom'if', var_prix;
        ELSE SELECT var_nom 'else', 'Le prix est différent de 210 et 220'AS 'Resultat';  
        END IF;
	  	END LOOP;
	/* fermeture du curseur */
	  CLOSE c_iphone;

	END; 
END


#########################################################################


/* SOMME TOTAL DES IPHONES */
somme_prix(IN marque INT(20))
BEGIN
    /* déclaration des variables */
    DECLARE v_totalPrix INT(5);
    DECLARE var_nom VARCHAR(55);
    DECLARE var_prix INT(5);
    DECLARE v_i INT(5) DEFAULT 0;
    DECLARE nb INT(5) DEFAULT 1;
    DECLARE done INT DEFAULT 0;
    
    /* bloc d'instructions Affichage du prix en fonction du nom */
    DECLARE c_somme CURSOR FOR
    SELECT nom, prix FROM produits;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done=1;
		
        SET v_totalPrix :=0;
        BEGIN

        /* initialisation de variable */
           SELECT COUNT(*) INTO nb FROM produits;
           
           
        /* ouverture du curseur */
           OPEN c_somme;
			
            prix_loop: REPEAT
            	 IF done = 1 THEN
                 LEAVE prix_loop;
                 END IF;
                FETCH c_somme INTO var_nom, var_prix;
                	IF var_nom = marque THEN
                	SET v_totalPrix = v_totalPrix + var_prix;
                    END IF;
                    SELECT v_totalPrix;
            	SET v_i=v_i+1;
            	UNTIL v_i=nb END REPEAT;
        /* fermeture du curseur */
          CLOSE c_somme;

        END; 
    END