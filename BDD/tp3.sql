#1
SELECT nompilote, adresse
FROM pilote

#2
SELECT DISTINCT villedep
FROM vol

#3
SELECT *
FROM vol
WHERE villedep = 'Paris' AND '14:00:00' <= heuredep AND heuredep <= '16:00:00'

#4
SELECT numavion, nomavion
FROM avion
WHERE nomavion LIKE '%Airbus%'

#5
SELECT nompilote
FROM pilote
WHERE nompilote LIKE '_i_%'

#6
SELECT *
FROM avion
WHERE capacite BETWEEN 200 AND 300

#7
SELECT numavion, nomavion, localisation
FROM avion
WHERE capacite > 200 AND localisation != 'Nice'
ORDER BY numavion DESC

#8
SELECT DISTINCT nompilote
FROM pilote P
INNER JOIN vol V ON P.numpilote = V.numpilote
WHERE villedep = 'Paris'

#9
SELECT DISTINCT nompilote
FROM pilote P
INNER JOIN vol V ON P.numpilote = V.numpilote
INNER JOIN avion A ON V.numavion = A.numavion
WHERE nomavion LIKE '%Airbus%'

#10
SELECT SUM(PRIX) AS "Somme des prix HT", AVG(PRIX) AS "Moyenne des prix HT",
       MIN(PRIX) AS "Prix minimum HT", MAX(PRIX) AS "Prix maximum HT"
FROM pilote P
INNER JOIN vol V ON P.numpilote = V.numpilote
WHERE nompilote = 'Wright'
