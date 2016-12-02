#1
SELECT nompilote, adresse
FROM TP3_vol.pilote

#2
SELECT DISTINCT villedep
FROM TP3_vol.vol

#3
SELECT *
FROM TP3_vol.vol
WHERE villedep = 'Paris' AND '14:00:00' <= heuredep AND heuredep <= '16:00:00'

#4
SELECT numavion, nomavion
FROM TP3_vol.avion
WHERE nomavion LIKE '%Airbus%'

#5
SELECT nompilote
FROM TP3_vol.avion
WHERE nompilote LIKE '_i_%'

#6
SELECT *
FROM TP3_vol.avion
WHERE capacite BETWEEN 200 AND 300

#7
SELECT numavion, nomavion, localisation
FROM TP3_vol.avion
WHERE capacite > 200 AND localisation != 'Nice'
ORDER BY numavion DESC

#8
SELECT DISTINCT nompilote
FROM TP3_vol.pilote P
INNER JOIN TP3_vol.vol V ON P.numpilote = V.numpilote
WHERE villedep = 'Paris'

#9
SELECT DISTINCT nompilote
FROM TP3_vol.pilote P
INNER JOIN TP3_vol.vol V ON P.numpilote = V.numpilote
INNER JOIN TP3_vol.avion A ON V.numavion = A.numavion
WHERE nomavion LIKE '%Airbus%'

#10
SELECT SUM(PRIX) AS "Somme des prix HT", AVG(PRIX) AS "Moyenne des prix HT",
       MIN(PRIX) AS "Prix minimum HT", MAX(PRIX) AS "Prix maximum HT"
FROM TP3_vol.pilote P
INNER JOIN TP3_vol.vol V ON P.numpilote = V.numpilote
WHERE nompilote = 'Wright'

#11
SELECT MAX(prix) AS "Prix Max au départ de Marseille"
FROM TP3_vol.vol
WHERE villedep='Marseille'

#12
SELECT nompilote
FROM TP3_vol.pilote P
INNER JOIN TP3_vol.vol V ON P.numpilote = V.numpilote
WHERE villedep = 'Paris' AND villearr = 'Alger'
INTERSECT
SELECT nompilote
FROM TP3_vol.pilote P
INNER JOIN TP3_vol.vol V ON P.numpilote = V.numpilote
WHERE villedep = 'Paris' AND villearr = 'Londres'

#13
SELECT nompilote
FROM TP3_vol.pilote P
EXCEPT
SELECT nompilote
FROM TP3_vol.pilote P
INNER JOIN TP3_vol.vol V ON P.numpilote = V.numpilote
WHERE villedep = 'Nice'

#14
SELECT nompilote
FROM TP3_vol.pilote P
EXCEPT
SELECT nompilote
FROM TP3_vol.pilote P
INNER JOIN TP3_vol.vol V ON P.numpilote = V.numpilote
WHERE villedep = 'Nice' OR villedep = 'Alger'

#15
SELECT numvol, villedep, villearr
FROM TP3_vol.vol
WHERE extract(hour from (heurearr - heuredep)) < 4

#16
SELECT COUNT(*) AS "Nombre d'Airbus"
FROM TP3_vol.avion
WHERE nomavion LIKE '%Airbus%'

#17
SELECT numvol, heurearr-heuredep AS "temps de vol"
FROM TP3_vol.vol

#18
SELECT MAX(heurearr-heuredep) AS "temps de vol max"
FROM TP3_vol.vol
