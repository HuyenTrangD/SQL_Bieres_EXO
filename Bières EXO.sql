SELECT * FROM ventes ;

SELECT * FROM ticket ;

# 1 - Afficher NUMERO_TICKET qui comportent ID_ARTICLE = 500
SELECT NUMERO_TICKET, ID_ARTICLE FROM ventes
WHERE ID_ARTICLE = 500 ;

# 2 - Afficher NUMERO_TICKET dont DATE_VENTE 15/01/2014
SELECT NUMERO_TICKET, DATE_VENTE FROM ticket
WHERE DATE_VENTE = '2014-01-15' ;

# 3 - Afficher NUMERO_TICKET émis DATE_VENTE du 15/01/2014 au 17/01/2014
SELECT NUMERO_TICKET, DATE_VENTE 
FROM ticket
WHERE DATE_VENTE 
	BETWEEN '2014-01-15' 
    AND '2014-01-17' ;
    
# 4 - Editer la liste ID_ARTICLE QUANTITE >= 50
SELECT ID_ARTICLE, QUANTITE
FROM ventes
WHERE QUANTITE >= 50 
ORDER BY ID_ARTICLE ;

# 4' - Editer la liste NOM_ARTICLE & ID_ARTICLE QUANTITE >= 50
SELECT NOM_ARTICLE, QUANTITE
FROM ventes
INNER JOIN article
	ON ventes.ID_ARTICLE = article.ID_ARTICLE
WHERE QUANTITE >= 50
ORDER BY QUANTITE ;

# 5 - ticket Afficher NUMERO_TICKET dont DATE_VENTE mars 2014
SELECT NUMERO_TICKET, DATE_VENTE
FROM ticket
WHERE DATE_VENTE
	BETWEEN '2014-03-01'
    AND '2014-03-31' ;
    
# 5' - ticket NUMERO_TICKET dont DATE_VENTE mars 2014
SELECT NUMERO_TICKET, DATE_VENTE
FROM ticket
WHERE 
	YEAR(DATE_VENTE) = 2014
	AND MONTH(DATE_VENTE) = 03 ;
    
# 6 - ticket NUMERO_TICKET émis DATE_VENTE BETWEEN mars '2014-03-01' AND avril 2014 '2014-04-30'
SELECT NUMERO_TICKET, DATE_VENTE
FROM ticket
WHERE DATE_VENTE
	BETWEEN '2014-03-01'
    AND '2014-04-30' ;

# 7 - ticket NUMERO_TICKET émis DATE_VENTE mars '2014-03-01' et juin 2014 '2014-06-30'
SELECT NUMERO_TICKET, DATE_VENTE
FROM ticket
WHERE 
	YEAR(DATE_VENTE) = 2014
    AND MONTH(DATE_VENTE) IN (03, 06) ;
    
# 8 - article Afficher la liste ID_ARTICLE, NOM_ARTICLE des bières classée ORDER BY par couleur NOM_COULEUR (couleur)
SELECT ID_ARTICLE, NOM_ARTICLE, NOM_COULEUR
FROM article
INNER JOIN couleur
	ON article.ID_Couleur = couleur.ID_Couleur
ORDER BY NOM_COULEUR ;

# 9 - article Afficher la liste ID_ARTICLE, NOM_ARTICLE n’ayant pas de couleur NOM_COULEUR IS NULL (couleur)
SELECT * FROM couleur ;

SELECT ID_ARTICLE, NOM_ARTICLE, ID_COULEUR
FROM article
WHERE ID_COULEUR IS NULL ;

# 10 - (ticket) Lister pour chaque ticket (NUMERO_TICKET & GROUP BY) la quantité totale d’articles vendus SUM(QUANTITE) classée par quantité décroissante ORDER BY DESC
SELECT 	NUMERO_TICKET ,
		SUM(QUANTITE) AS 'Quantité totale'
FROM ventes
GROUP BY NUMERO_TICKET
ORDER BY 'Quantité totale' DESC ;

# 11 - (ticket) Lister pour chaque ticket (NUMERO_TICKET & GROUP BY) la quantité totale d’articles vendus SUM(QUANTITE) > 500 classée par quantité décroissante ORDER BY DESC
SELECT 	NUMERO_TICKET ,
		SUM(QUANTITE) AS 'Quantité'
FROM ventes
GROUP BY NUMERO_TICKET
HAVING Quantité > 500
ORDER BY Quantité DESC ;

# 12 - Lister chaque ticket NUMERO_TICKET pour lequel la quantité totale d’articles vendus SUM(QUANTITE) > 500. 
# On exclura du total, les ventes ayant une quantité inférieure à 50 (classer par quantité décroissante) ORDER BY desc

SELECT 	NUMERO_TICKET ,
		SUM(QUANTITE) AS 'Quantite'
FROM ventes
WHERE QUANTITE < 50
GROUP BY NUMERO_TICKET
HAVING Quantite > 500
ORDER BY Quantite DESC ;

SELECT MAX(QUANTITE) FROM ventes ;

SELECT COUNT(QUANTITE) FROM ventes ;

# 13 - Lister les bières ID_ARTICLE, NOM_ARTICLE, VOLUME, TITRAGE de type ‘Trappiste’ NOM_TYPE
SELECT * FROM type ;

SELECT ID_ARTICLE, NOM_ARTICLE, VOLUME, TITRAGE, NOM_TYPE
FROM article
INNER JOIN type
	ON article.ID_TYPE = type.ID_TYPE
WHERE NOM_TYPE = 'Trappiste' ;

# 14 - Lister les marques de bières NOM_MARQUE du continent ‘Afrique’ NOM_CONTINENT
SELECT NOM_MARQUE, NOM_CONTINENT
FROM marque
INNER JOIN pays
	ON marque.ID_PAYS = pays.ID_PAYS
INNER JOIN continent
	ON pays.ID_CONTINENT = pays.ID_CONTINENT
	WHERE NOM_CONTINENT = 'Afrique' ;
    
# POURQUOI RESULTAT #
SELECT marque.NOM_MARQUE, marque.ID_PAYS, NOM_CONTINENT
	FROM marque
INNER JOIN pays
	ON marque.ID_PAYS = pays.ID_PAYS
INNER JOIN continent
	ON pays.ID_CONTINENT = continent.ID_CONTINENT
	WHERE NOM_CONTINENT = 'Afrique';

# 15 - Lister les bières NOM_ARTICLE du continent ‘Afrique' NOM_CONTINENT
SELECT ID_ARTICLE, NOM_ARTICLE, NOM_CONTINENT
FROM article
INNER JOIN marque
	ON article.ID_MARQUE = marque.ID_MARQUE
INNER JOIN pays
	ON marque.ID_PAYS = pays.ID_PAYS
INNER JOIN continent
	ON pays.ID_CONTINENT = pays.ID_CONTINENT
	WHERE NOM_CONTINENT = 'Afrique'
ORDER BY NOM_ARTICLE ;

# 16 - Lister les tickets (année, numéro de ticket, montant total payé). 
# En sachant que le prix de vente est égal au prix d’achat augmenté de 15% et que l’on n’est pas assujetti à la TVA
SELECT 	ANNEE, NUMERO_TICKET,
		ROUND(SUM(QUANTITE * PRIX_ACHAT) * 1.15) AS Total
FROM ventes
INNER JOIN article
	ON ventes.ID_ARTICLE = article.ID_ARTICLE
GROUP BY ANNEE, NUMERO_TICKET
ORDER BY ANNEE ;

# 17 -  Donner le C.A. SUM(VENTE) par année GROUP BY ANNEE
SELECT 	ANNEE,
		ROUND(SUM(QUANTITE * PRIX_ACHAT) * 1.15) AS Total
FROM ventes
INNER JOIN article
	ON ventes.ID_ARTICLE = article.ID_ARTICLE
GROUP BY ANNEE ;

# 18 - Lister les quantités vendues SUM(QUANTITE) de chaque article ID_ARTICLE pour l’année 2016 ANNEE
SELECT * FROM ventes
WHERE ANNEE = 2016
ORDER BY ID_ARTICLE ;

SELECT 	ANNEE, ID_ARTICLE,
		SUM(QUANTITE) AS 'Total'
FROM ventes
WHERE ANNEE = 2016
GROUP BY ID_ARTICLE
ORDER BY ID_ARTICLE ;

# 19 -  Lister les quantités vendues SUM(QUANTITE) de chaque article GROUP BY (ID_ARTICLE) pour les années 2014, 2015, 2016 GROUP BY (ANNEE) 
SELECT 	ANNEE, ID_ARTICLE,
		SUM(QUANTITE) AS 'Total'
FROM ventes
GROUP BY ID_ARTICLE, ANNEE ;

# 20 - Lister les articles (ID_ARTICLE) qui n’ont fait l’objet d’aucune vente en 2014 ANNEE = 2014 & QUANTITE = 0
SELECT ID_ARTICLE, NOM_ARTICLE
FROM article
WHERE (
		SELECT SUM(QUANTITE)
        FROM ventes
        WHERE articLe.ID_ARTICLE = ventes.ID_ARTICLE
			AND ANNEE = 2014
	) IS NULL ;

# 21 - Lister les pays NOM_PAYS qui fabriquent des bières de type ‘Trappiste’. NOM_TYPE
SELECT DISTINCT NOM_PAYS, NOM_TYPE
FROM pays
INNER JOIN marque
	ON pays.ID_PAYS = marque.ID_PAYS
INNER JOIN article
	ON marque.ID_MARQUE = article.ID_MARQUE
INNER JOIN type
	ON article.ID_TYPE = type.ID_TYPE
	WHERE NOM_TYPE = 'Trappiste' ;
    
# 22 - Lister les tickets NUMERO_TICKET sur lesquels apparaissent un des articles ID_ARTICLE apparaissant aussi 
# sur le ticket 856 (NUMERO_TICKET) de l’année 2014 (ANNEE)
SELECT DISTINCT NUMERO_TICKET, ID_ARTICLE
FROM ventes
WHERE ID_ARTICLE IN
	(SELECT ID_ARTICLE
		FROM ventes
		WHERE NUMERO_TICKET = 856
			AND ANNEE = 2014)
ORDER BY NUMERO_TICKET ;

# 23 - Lister les articles ID_ARTICLE, NOM_ARTICLE 
# ayant un degré d’alcool TITRAGE > MAX(TITRAGE) plus élevé que la plus forte des trappistes WHERE NOM_TYPE = Trappiste
SELECT ID_ARTICLE, NOM_ARTICLE, TITRAGE
FROM article
WHERE TITRAGE > (
	SELECT MAX(TITRAGE)
    FROM article
    INNER JOIN type
		ON article.ID_TYPE = type.ID_TYPE
	WHERE NOM_TYPE = 'Trappiste')
ORDER BY TITRAGE ;

# 24 - Editer les quantités vendues SUM(QUANTITE)/vente pour chaque couleur ID_COULEUR/couleur en 2014 ANNEE
SELECT * FROM couleur ;

SELECT 	ANNEE ,
		ID_Couleur ,
		SUM(QUANTITE) AS 'Total'
FROM ventes
INNER JOIN article
	ON ventes.ID_ARTICLE = article.ID_ARTICLE
WHERE ANNEE = 2014 
GROUP BY ID_Couleur
ORDER BY ID_Couleur ;

# 25 - Donner pour chaque fabricant ID_FABRICANT, NOM_FABRICANT le nombre de tickets COUNT(NUMERO_TICKET)
# sur lesquels apparait un de ses produits en 2014 ANNEE

SELECT 	ANNEE ,
		COUNT(NUMERO_TICKET) AS 'Tickets',
		NOM_FABRICANT
FROM ventes
INNER JOIN article
	ON ventes.ID_ARTICLE = article.ID_ARTICLE
INNER JOIN marque
	ON article.ID_MARQUE = marque.ID_MARQUE
INNER JOIN fabricant
	ON marque.ID_FABRICANT = fabricant.ID_FABRICANT
WHERE ANNEE = 2014 ;

SELECT 	ID_FABRICANT ,
		NOM_FABRICANT, 
        (SELECT COUNT(*) 
			FROM ticket 
            WHERE CONCAT(ANNEE, NUMERO_TICKET) IN 
				(SELECT CONCAT(ANNEE, NUMERO_TICKET)  
					FROM ventes 
                    WHERE ANNEE = 2014 
						AND ID_ARTICLE IN 
							(SELECT ID_ARTICLE 
								FROM article 
								WHERE ID_MARQUE IN 
									(SELECT ID_MARQUE 
										FROM marque 
										WHERE ID_FABRICANT = F.ID_FABRICANT
			)))) as 'Nbre Tickets 2014' 
FROM fabricant as F
ORDER BY 'Nbre Tickets 2014' DESC ;

# 26 -  Donner l'ID, le nom, le volume et la quantité vendue des 20 articles les plus vendus en 2016
# article (ID_ARTICLE, NOM_ARTICLE, VOLUME) & ventes SUM(QUANTITE) / ORDER BY DESC / LIMIT 20 / ANNEE = 2016

SELECT 	article.ID_ARTICLE, NOM_ARTICLE, VOLUME,
		SUM(QUANTITE) AS 'Total'
FROM article
INNER JOIN ventes
	ON article.ID_ARTICLE = ventes.ID_ARTICLE
WHERE ANNEE = 2016
GROUP BY ID_ARTICLE
ORDER BY Total DESC
LIMIT 20 ;

# 27 - Donner l’ID, le nom, le volume et la quantité vendue des 5 ‘Trappistes’ les plus vendus en 2016
# article (ID_ARTICLE, NOM_ARTICLE, VOLUME) & ventes SUM(QUANTITE) LIMIT 5 / ANNEE = 2015

SELECT 	article.ID_ARTICLE ,
		article.NOM_ARTICLE ,
        article.VOLUME ,
        SUM(QUANTITE) AS Total
FROM ventes
JOIN article
	ON ventes.ID_ARTICLE = article.ID_ARTICLE
JOIN type
	ON article.ID_TYPE = type.ID_TYPE
WHERE type.NOM_TYPE = 'Trappiste'
	AND ventes.ANNEE = 2016
GROUP BY article.ID_ARTICLE
ORDER BY Total DESC
LIMIT 5 ;

# 27' - Donner l’ID, le nom, le volume et la quantité vendue des 5 ‘Trappistes’ les plus vendus en 2016
# article (ID_ARTICLE, NOM_ARTICLE, VOLUME) & ventes SUM(QUANTITE) LIMIT 5 / ANNEE = 2015

SELECT ID_ARTICLE, NOM_ARTICLE, VOLUME, SUM(QUANTITE) as quantite_totale
FROM article
JOIN ventes USING(ID_ARTICLE)
JOIN type USING(id_type)
WHERE ANNEE = 2016
	AND NOM_TYPE = 'Trappiste'
GROUP BY ID_ARTICLE
ORDER BY quantite_totale desc
LIMIT 5 ;

# 28 -  Donner l’ID, le nom, le volume et les quantités vendues en 2015 et 2016, des bières dont les ventes ont été stables < 1% de variation
# article (ID_ARTICLE, NOM_ARTICLE, VOLUME) & ventes SUM(QUANTITE) / ANNEE = 2015 AND 2016 & ventes 2016 - ventes 2015

SELECT 	article.ID_ARTICLE ,
		article.NOM_ARTICLE ,
		article.VOLUME ,
        ventes.ANNEE ,
        SUM(QUANTITE) AS Total
FROM article
INNER JOIN ventes
	ON article.ID_ARTICLE = ventes.ID_ARTICLE
WHERE ANNEE = 2015
	AND ANNEE = 2016
    AND SUM(QUANTITE) 
GROUP BY ID_ARTICLE , ANNEE ;

# 28' -  Donner l’ID, le nom, le volume et les quantités vendues en 2015 et 2016, des bières dont les ventes ont été stables < 1% de variation
# article (ID_ARTICLE, NOM_ARTICLE, VOLUME) & ventes SUM(QUANTITE) / ANNEE = 2015 AND 2016 & ventes 2016 - ventes 2015

SELECT 	article.ID_ARTICLE,
		article.NOM_ARTICLE,
		article.VOLUME,
        R15.QTE2015 AS R15 ,
        R16.QTE2016 AS R16 ,
		((R16.QTE2016 - R15.QTE2015) / R15.QTE2015) AS VARIATION
FROM article	

JOIN (
	SELECT ID_ARTICLE, SUM(QUANTITE) AS QTE2015
    FROM ventes
	WHERE ANNEE = 2015
	GROUP BY ID_ARTICLE 
    ) AS R15 
ON article.ID_ARTICLE = R15.ID_ARTICLE

JOIN (
	SELECT ID_ARTICLE, SUM(QUANTITE) AS QTE2016
    FROM ventes
	WHERE ANNEE = 2016
    GROUP BY ID_ARTICLE 
    ) AS R16 
on Article.ID_ARTICLE = R16.ID_ARTICLE

HAVING ABS(VARIATION) < 0.01
ORDER BY ID_ARTICLE ;

# 28'' -  Donner l’ID, le nom, le volume et les quantités vendues en 2015 et 2016, des bières dont les ventes ont été stables < 1% de variation
# article (ID_ARTICLE, NOM_ARTICLE, VOLUME) & ventes SUM(QUANTITE) / ANNEE = 2015 AND 2016 & ventes 2016 - ventes 2015

SELECT
	ID_ARTICLE, NOM_ARTICLE, VOLUME,
    t2015.quantite_vendue AS Vente_2015,
    t2016.quantite_vendue AS Vente_2016,
	CONCAT(ROUND((t2016.quantite_vendue - t2015.quantite_vendue) / t2015.quantite_vendue * 100, 2), ' %') as Variation_2015_2016
FROM article

INNER JOIN (
			SELECT ID_ARTICLE, SUM(QUANTITE) AS quantite_vendue
			FROM article
			JOIN ventes USING(ID_ARTICLE)
				WHERE ANNEE = 2015
			GROUP BY ID_ARTICLE
			ORDER BY quantite_vendue DESC
			) t2015 USING(ID_ARTICLE)

INNER JOIN (
			SELECT ID_ARTICLE, SUM(QUANTITE) as quantite_vendue
			FROM article
			JOIN ventes USING(ID_ARTICLE)
				WHERE ANNEE = 2016
			GROUP BY ID_ARTICLE
			ORDER BY quantite_vendue DESC
			) t2016 USING(ID_ARTICLE)
            
WHERE ABS((t2016.quantite_vendue - t2015.quantite_vendue) / t2015.quantite_vendue * 100) < 1
ORDER BY Variation_2015_2016 ;

# 29 - Lister les types de bières suivant l’évolution de leurs ventes entre 2015 et 2016. Classer le résultat par ordre décroissant des performances.
# NOM_TYPE/ type & évolution ventes 2015-2016 & ORDER BY Variation_2015_2016 DESC

SELECT
	ID_ARTICLE, NOM_ARTICLE, VOLUME, NOM_TYPE ,
    t2015.quantite_vendue AS Vente_2015,
    t2016.quantite_vendue AS Vente_2016,
	CONCAT(ROUND((t2016.quantite_vendue - t2015.quantite_vendue) / t2015.quantite_vendue * 100, 2), ' %') as Variation_2015_2016
FROM article

INNER JOIN type USING(ID_TYPE)

INNER JOIN (
			SELECT ID_ARTICLE, SUM(QUANTITE) AS quantite_vendue
			FROM article
			JOIN ventes USING(ID_ARTICLE)
				WHERE ANNEE = 2015
			GROUP BY ID_ARTICLE
			ORDER BY quantite_vendue DESC
			) t2015 USING(ID_ARTICLE)

INNER JOIN (
			SELECT ID_ARTICLE, SUM(QUANTITE) as quantite_vendue
			FROM article
			JOIN ventes USING(ID_ARTICLE)
				WHERE ANNEE = 2016
			GROUP BY ID_ARTICLE
			ORDER BY quantite_vendue DESC
			) t2016 USING(ID_ARTICLE)
            
ORDER BY Variation_2015_2016 DESC ;

# 30 - Existe-t-il des tickets sans vente ?
# NUMERO_TICKET QUANTITE = 0

SELECT NUMERO_TICKET,  QUANTITE
FROM ventes
WHERE QUANTITE = 0 ;

SELECT *
FROM ventes
WHERE NUMERO_TICKET = 1138
	AND ANNEE = 2016 ;
    
SELECT DISTINCTROW
    numero_ticket,
    annee
FROM ticket
LEFT JOIN ventes USING(numero_ticket, annee)
    WHERE id_article IS NULL ;

# 31 - Lister les produits vendus en 2016 dans des quantités jusqu’à -15% des quantités de l’article le plus vendu
# ventes ID_ARTICLE, NOM_ARTICLE, ANNEE = 2016, QUANTITE = -0,15 MAX(SUM)QUANTITTE

SELECT 	ID_ARTICLE, ANNEE, QUANTITE
FROM ventes
WHERE QUANTITE < (SELECT MAX(SUM(QUANTITE))
					FROM ventes
                    WHERE ANNEE = 2016 )
GROUP BY ID_ARTICLE ;

# 32. Appliquer une augmentation de tarif de 10% pour toutes les bières ‘Trappistes’ de couleur ‘Blonde’	
# PRIX_ACHAT * 10% 1.1, NOM_TYPE = 'Trappiste', NOM_COULEUR = 'Blonde'

SELECT 	ID_ARTICLE ,
		PRIX_ACHAT ,
		ROUND(PRIX_ACHAT * 1.1, 2) AS Nouveau_Prix ,
        NOM_TYPE ,
        NOM_COULEUR
FROM type
JOIN article USING(ID_TYPE)
JOIN couleur USING(ID_COULEUR)
WHERE NOM_TYPE = 'Trappiste'
	AND NOM_COULEUR = 'Blonde'
ORDER BY Nouveau_Prix ;

UPDATE article
JOIN type USING(ID_TYPE)
JOIN couleur USING(ID_COULEUR)
SET PRIX_ACHAT = ROUND(PRIX_ACHAT * 1.1, 2)
WHERE NOM_TYPE = 'Trappiste'
    AND NOM_COULEUR = 'Blonde' ;

# 33 - Mettre à jour le degré d’alcool des toutes les bières n’ayant pas cette information.
# On y mettra le degré d’alcool de la moins forte des bières du même type et de même couleur.
# TITRAGE is null , MIN(TITRAGE) NOM_TYPE NOM_COULEUR

update article
JOIN type USING(ID_TYPE)
JOIN couleur USING(ID_COULEUR)
set TITRAGE = (SELECT MIN(TITRAGE))
WHERE NOM_TYPE LIKE (SELECT NOM_TYPE
					FROM type
                    WHERE TITRAGE = MIN(TITRAGE))
	AND NOM_COULEUR LIKE (SELECT NOM_COULEUR
					FROM couleur
                    WHERE TITRAGE = MIN(TITRAGE)) ;
                    
UPDATE article
LEFT JOIN type USING(id_type)
LEFT JOIN couleur USING(id_couleur)
LEFT JOIN (
    SELECT DISTINCTROW
        article.id_type,
        article.id_couleur,
        MIN(titrage) AS titrage_min
    FROM article
    LEFT JOIN type USING(id_type)
    LEFT JOIN couleur USING(id_couleur)
    GROUP BY article.id_type, article.id_couleur
) t_titr_min USING(id_type, id_couleur)
SET titrage = titrage_min
WHERE titrage IS NULL
   OR titrage REGEXP '^\s*$' ;
   
# 34 - Suppression des bières qui ne sont pas des bières ! (Type ‘Bière Aromatisée’)
select *
from type ;

delete *
from article
join type using(ID_TYPE)
where NOM_TYPE = ‘Bière Aromatisée’ ;

SET FOREIGN_KEY_CHECKS = 0;
DELETE type, article, ventes
FROM type
LEFT JOIN article USING(id_type)
LEFT JOIN ventes USING(id_article)
WHERE nom_type = 'Bière Aromatisée'
;
SET FOREIGN_KEY_CHECKS = 1;
COMMIT;

# 35 - Supprimer les tickets qui n’ont pas de ventes
		
DELETE NUMERO_TICKET
FROM ventes
WHERE QUANTITE = 0 ;

SELECT DISTINCTROW
    numero_ticket,
    annee
FROM ticket
LEFT JOIN ventes USING(numero_ticket, annee)
    WHERE id_article IS NULL ;
    
DELETE ticket, ventes
FROM ticket
LEFT JOIN ventes USING(annee, numero_ticket)
WHERE id_article IS NULL
;


    
        
                    
	

