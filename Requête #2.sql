/* Obtenir la liste des 10 ville les plus peuplées en 2012 */
SELECT * FROM villes_france_free
ORDER BY ville_population_2012 DESC
LIMIT 10;

/*Obtenir la liste des 50 villes ayant la plus faible superficie */
SELECT * FROM villes_france_free
ORDER BY ville_surface ASC
LIMIT 50;

/* Obtenir la liste des départements d'outres-mer commençant par "97" */
SELECT * FROM departement
WHERE departement_code LIKE "97%";

/* Obtenir la liste des 10 villes les plus peuplées de 2012 et le nom du departement associé */
SELECT * FROM villes_france_free
LEFT JOIN departement ON departement_code = ville_departement
ORDER BY ville_population_2012 DESC 
LIMIT 10;

/* Obtenir la liste du nom de chaque departement, associé à son code et du nombre de commune au sein des departements, en triant pour avoir en priorité les departements avec le + de commmunes
SELECT departement_nom, ville_departement, COUNT(*) AS nbr_items 
FROM villes_france_free
LEFT JOIN departement ON departement_code = ville_departement
GROUP BY 'ville_departement'
ORDER BY nbr_items DESC; */

/* Obtenir la liste des 10 plus grand departement en termen de superficie
SELECT departement_nom, ville_departement, SUM(ville_surface) AS dpt_surface 
FROM villes_france_free 
LEFT JOIN departement ON departement_code = ville_departement
GROUP BY ville_departement  
ORDER BY dpt_surface  DESC
LIMIT 10; */

/* Compter le nombre de ville commençant pas "Saint */
SELECT COUNT(*) 
FROM `villes_france_free` 
WHERE `ville_nom` LIKE 'saint%';

/* Obtenir la liste des ville qui ont un nom existant plusieur fois, trier par nom le plus souvent utilisé */
SELECT ville_nom, COUNT(*) AS nbt_item 
FROM villes_france_free 
GROUP BY ville_nom 
ORDER BY nbt_item DESC;

/* Obtenir la liste des villes dont la superficie est superieure à la superficie moyenne */
SELECT * 
FROM villes_france_free 
WHERE `ville_surface` > (SELECT AVG(`ville_surface`) FROM villes_france_free);

/* Obtenir la liste des departement qui ont plus de 2 millions d'habitants */
SELECT ville_departement, SUM(`ville_population_2012`) AS population_2012
FROM villes_france_free
GROUP BY `ville_departement`
HAVING population_2012 > 2000000
ORDER BY population_2012 DESC;

/* Remplacer les tirets par un espace vide pour les villes qui commmencent pas "Saint-" */
UPDATE villes_france_free 
SET ville_nom = REPLACE(ville_nom, '-', ' ') 
WHERE `ville_nom` LIKE 'SAINT-%';

/* Nom du/des lieux possedant le plus d'habitants, en dehors du village gaulois */
SELECT  nom_lieu,COUNT(nom_personnage)
FROM personnage
INNER JOIN lieu ON personnage.id_lieu = lieu.id_lieu
WHERE nom_lieu NOT LIKE 'Village gaulois'
GROUP BY nom_lieu

/*Nom des personnages qui n'ont jamais bu aucune potion */
SELECT nom_personnage
FROM personnage
LEFT JOIN boire ON personnage.id_personnage = boire.id_personnage
WHERE dose_boire IS NULL
GROUP BY nom_personnage

/*Nom du / des personnages qui n'ont pas le droit de boire de la potion 'Magique' */
SELECT nom_personnage
FROM personnage
LEFT JOIN boire ON personnage.id_personnage = boire.id_personnage
LEFT JOIN potion ON boire.id_potion = potion.id_potion
WHERE LOWER(nom_potion) NOT LIKE 'magique'
GROUP BY personnage.nom_personnage
