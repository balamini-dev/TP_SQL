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