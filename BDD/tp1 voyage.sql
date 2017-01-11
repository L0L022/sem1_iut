-- requetes simples

-- 1
SELECT *
FROM tp1_bd_voyage.client

-- 2
SELECT *
FROM tp1_bd_voyage.client
WHERE categorie = 'PRIVILEGIE'

-- 3
SELECT nom, prenom
FROM tp1_bd_voyage.client
WHERE ville = 'MARSEILLE'

-- 4
SELECT nom
FROM tp1_bd_voyage.client
WHERE ville = 'MARSEILLE' AND prenom LIKE '%R%'

-- 5
SELECT R.numcl, idv
FROM tp1_bd_voyage.client C
INNER JOIN tp1_bd_voyage.reservation R ON C.numcl = R.numcl
WHERE '2003-03-01' <= dateres AND dateres <= '2004-01-31'
-- ou
SELECT R.numcl, idv
FROM tp1_bd_voyage.client C
INNER JOIN tp1_bd_voyage.reservation R ON C.numcl = R.numcl
WHERE dateres BETWEEN '2003-03-01' AND '2004-01-31'
-- ou
SELECT numcl, idv
FROM tp1_bd_voyage.reservation
WHERE (extract(year FROM dateres)=2003 AND extract(month FROM dateres)>=03)
OR (extract(year FROM dateres)=2004 AND extract(month FROM dateres)=01) ;

-- 6
SELECT idv, duree
FROM tp1_bd_voyage.voyage
WHERE voyage.paysarr = 'MAROC' OR hotel = 'ANTIQUE'

-- 7
SELECT villearr
FROM tp1_bd_voyage.voyage
WHERE paysarr = 'MAROC'

-- 8
SELECT *
FROM tp1_bd_voyage.optionv
WHERE libelle LIKE '%VISITE%'

-- 9
SELECT datedep
FROM tp1_bd_voyage.planning
WHERE idv = 927 AND datedep BETWEEN '2004-06-01' AND '2004-07-30'
ORDER BY datedep DESC

-- 10
SELECT numcl, nom, prenom
FROM tp1_bd_voyage.client
WHERE ville != 'PARIS' AND ville != 'MARSEILLE'
ORDER BY numcl
-- ou
SELECT numcl, nom, prenom
FROM tp1_bd_voyage.client
EXCEPT
SELECT numcl, nom, prenom
FROM tp1_bd_voyage.client
WHERE ville = 'PARIS'
EXCEPT
SELECT numcl, nom, prenom
FROM tp1_bd_voyage.client
WHERE ville = 'MARSEILLE'
ORDER BY numcl
-- ou
SELECT numcl, nom, prenom
FROM tp1_bd_voyage.client
EXCEPT
SELECT numcl, nom, prenom
FROM tp1_bd_voyage.client
WHERE ville IN ('PARIS','MARSEILLE')
ORDER BY numcl
-- ou
SELECT numcl, nom, prenom
FROM tp1_bd_voyage.client
WHERE ville NOT IN ('PARIS','MARSEILLE')
ORDER BY numcl
-- ou
SELECT numcl, nom, prenom
FROM tp1_bd_voyage.client
WHERE ville != 'PARIS'
INTERSECT
SELECT numcl, nom, prenom
FROM tp1_bd_voyage.client
WHERE ville != 'MARSEILLE'
ORDER BY numcl

-- 11
SELECT numcl, nom
FROM tp1_bd_voyage.client
WHERE adresse IS NULL

-- sous requetes et operateurs ensemblistes

-- 1
SELECT DISTINCT V.idv, villearr, paysarr
FROM tp1_bd_voyage.voyage V
INNER JOIN tp1_bd_voyage.planning P ON V.idv = P.idv
WHERE tarif = (
  SELECT MIN(tarif)
  FROM tp1_bd_voyage.planning
)
--
SELECT DISTINCT voyage.idv, villearr, paysarr
FROM tp1_bd_voyage.voyage
JOIN tp1_bd_voyage.planning ON voyage.idv = planning.idv
WHERE tarif <= ALL (
  SELECT tarif
  FROM tp1_bd_voyage.planning
)

-- 2
SELECT villearr, paysarr
FROM tp1_bd_voyage.voyage V
INNER JOIN tp1_bd_voyage.planning P ON V.idv = P.idv
GROUP BY V.idv, villearr, tarif
HAVING tarif >= ALL(
  SELECT tarif
  FROM tp1_bd_voyage.voyage V
  INNER JOIN tp1_bd_voyage.planning P ON V.idv = P.idv
)
-- ou
SELECT DISTINCT villearr, paysarr
FROM tp1_bd_voyage.voyage V
INNER JOIN tp1_bd_voyage.planning P ON V.idv = P.idv
WHERE tarif = (
  SELECT MAX(tarif)
  FROM tp1_bd_voyage.planning
)

-- 3
SELECT villedep
FROM tp1_bd_voyage.voyage
INTERSECT
SELECT ville
FROM tp1_bd_voyage.client
-- ou
SELECT DISTINCT villedep
FROM tp1_bd_voyage.voyage V
INNER JOIN tp1_bd_voyage.client C ON V.villedep = C.ville

-- 4
SELECT O.libelle
FROM tp1_bd_voyage.optionv O
INNER JOIN tp1_bd_voyage.carac C ON O.code = C.code
INNER JOIN tp1_bd_voyage.voyage V ON C.idv = V.idv
WHERE V.idv = 354 AND O.libelle IN (
  SELECT DISTINCT O.libelle
  FROM tp1_bd_voyage.optionv O
  INNER JOIN tp1_bd_voyage.carac C ON O.code = C.code
  INNER JOIN tp1_bd_voyage.voyage V ON C.idv = V.idv
  WHERE V.idv = 952
)
-- ou
SELECT O.libelle
FROM tp1_bd_voyage.optionv O
INNER JOIN tp1_bd_voyage.carac C ON O.code = C.code
INNER JOIN tp1_bd_voyage.voyage V ON C.idv = V.idv
WHERE V.idv = 354
INTERSECT
SELECT O.libelle
FROM tp1_bd_voyage.optionv O
INNER JOIN tp1_bd_voyage.carac C ON O.code = C.code
INNER JOIN tp1_bd_voyage.voyage V ON C.idv = V.idv
WHERE V.idv = 952

-- 5
SELECT V.idv, V.villedep, V.paysarr
FROM tp1_bd_voyage.voyage V
EXCEPT
SELECT V.idv, V.villedep, V.paysarr
FROM tp1_bd_voyage.voyage V
INNER JOIN tp1_bd_voyage.planning P ON V.idv = P.idv
INNER JOIN tp1_bd_voyage.reservation R ON P.idv = R.idv AND P.datedep = R.datedep
ORDER BY V.idv
-- ou
SELECT V.idv, V.villedep, V.paysarr
FROM tp1_bd_voyage.voyage V
WHERE idv NOT IN (
  SELECT V.idv
  FROM tp1_bd_voyage.voyage V
  INNER JOIN tp1_bd_voyage.planning P ON V.idv = P.idv
  INNER JOIN tp1_bd_voyage.reservation R ON P.idv = R.idv AND P.datedep = R.datedep
)
ORDER BY V.idv
-- ou
SELECT V.idv, V.villedep, V.paysarr
FROM tp1_bd_voyage.voyage V
WHERE idv <> ALL (
  SELECT V.idv
  FROM tp1_bd_voyage.voyage V
  INNER JOIN tp1_bd_voyage.planning P ON V.idv = P.idv
  INNER JOIN tp1_bd_voyage.reservation R ON P.idv = R.idv AND P.datedep = R.datedep
)
ORDER BY V.idv

-- 6
SELECT O.libelle
FROM tp1_bd_voyage.optionv O
INNER JOIN tp1_bd_voyage.carac C ON O.code = C.code
INNER JOIN tp1_bd_voyage.voyage V ON C.idv = V.idv
WHERE V.idv = 354 AND C.prix IS NULL
UNION
SELECT O.libelle
FROM tp1_bd_voyage.optionv O
INNER JOIN tp1_bd_voyage.carac C ON O.code = C.code
INNER JOIN tp1_bd_voyage.voyage V ON C.idv = V.idv
WHERE V.idv = 952 AND C.prix IS NOT NULL
-- ou
SELECT O.libelle
FROM tp1_bd_voyage.optionv O
INNER JOIN tp1_bd_voyage.carac C ON O.code = C.code
INNER JOIN tp1_bd_voyage.voyage V ON C.idv = V.idv
WHERE (V.idv = 354 AND C.prix IS NULL) OR (V.idv = 952 AND C.prix IS NOT NULL)

-- 7
SELECT V.idv, V.villearr
FROM tp1_bd_voyage.optionv O
INNER JOIN tp1_bd_voyage.carac C ON O.code = C.code
INNER JOIN tp1_bd_voyage.voyage V ON C.idv = V.idv
WHERE O.libelle = 'VISITE GUIDEE'
INTERSECT
SELECT V.idv, V.villearr
FROM tp1_bd_voyage.optionv O
INNER JOIN tp1_bd_voyage.carac C ON O.code = C.code
INNER JOIN tp1_bd_voyage.voyage V ON C.idv = V.idv
WHERE O.libelle = 'PISCINE'
-- ou
SELECT V.idv, V.villearr
FROM tp1_bd_voyage.optionv O
INNER JOIN tp1_bd_voyage.carac C ON O.code = C.code
INNER JOIN tp1_bd_voyage.voyage V ON C.idv = V.idv
WHERE O.libelle = 'VISITE GUIDEE' AND V.idv IN (
  SELECT V.idv
  FROM tp1_bd_voyage.optionv O
  INNER JOIN tp1_bd_voyage.carac C ON O.code = C.code
  INNER JOIN tp1_bd_voyage.voyage V ON C.idv = V.idv
  WHERE O.libelle = 'PISCINE'
)

-- 8
SELECT C.nom, C.prenom
FROM tp1_bd_voyage.client C
EXCEPT
SELECT C.nom, C.prenom
FROM tp1_bd_voyage.client C
INNER JOIN tp1_bd_voyage.reservation R ON C.numcl = R.numcl
-- ou
SELECT C.nom, C.prenom
FROM tp1_bd_voyage.client C
WHERE C.numcl NOT IN (
  SELECT C.numcl
  FROM tp1_bd_voyage.client C
  INNER JOIN tp1_bd_voyage.reservation R ON C.numcl = R.numcl
)
-- ou

-- 9
SELECT V.villearr, V.paysarr
FROM tp1_bd_voyage.voyage V
EXCEPT
SELECT V.villearr, V.paysarr
FROM tp1_bd_voyage.voyage V
WHERE villedep = 'MARSEILLE'

-- 10
SELECT *
FROM tp1_bd_voyage.optionv
EXCEPT
SELECT O.code, O.libelle
FROM tp1_bd_voyage.optionv O
INNER JOIN tp1_bd_voyage.carac C ON O.code = C.code
INNER JOIN tp1_bd_voyage.voyage V ON C.idv = V.idv
WHERE V.paysarr = 'CHYPRE'

-- 11
SELECT DISTINCT hotel
FROM tp1_bd_voyage.voyage
WHERE nbetoiles = (
  SELECT MAX(nbetoiles)
  FROM tp1_bd_voyage.voyage
)

-- 12
SELECT paysarr
FROM tp1_bd_voyage.voyage
EXCEPT
SELECT DISTINCT paysarr
FROM tp1_bd_voyage.voyage
WHERE hotel IN (
  SELECT DISTINCT hotel
  FROM tp1_bd_voyage.voyage
  WHERE nbetoiles = (
    SELECT MAX(nbetoiles)
    FROM tp1_bd_voyage.voyage
  )
)

-- 13
SELECT paysarr, COUNT(hotel) AS "NB hotel"
FROM tp1_bd_voyage.voyage
WHERE paysarr IN (
  SELECT DISTINCT paysarr
  FROM tp1_bd_voyage.voyage
  WHERE nbetoiles = (
    SELECT MAX(nbetoiles)
    FROM tp1_bd_voyage.voyage
  )
)
GROUP BY paysarr

-- operations de partitionnement

-- 1
SELECT paysarr, COUNT(*) AS "Nombre"
FROM tp1_bd_voyage.voyage
GROUP BY paysarr

-- 2
SELECT paysarr, villearr, COUNT(*) AS "Nombre"
FROM tp1_bd_voyage.voyage
GROUP BY paysarr, villearr

-- 3
SELECT paysarr, COUNT(DISTINCT villearr) AS "Nombre"
FROM tp1_bd_voyage.voyage
GROUP BY paysarr

-- 4
SELECT V.idv, villearr, COUNT(datedep) AS "Nombre"
FROM tp1_bd_voyage.voyage V
INNER JOIN tp1_bd_voyage.planning P ON V.idv = P.idv
GROUP BY V.idv, villearr

-- 5
SELECT V.idv, villearr, COUNT(*) AS "Nombre"
FROM tp1_bd_voyage.voyage V
INNER JOIN tp1_bd_voyage.carac C ON V.idv = C.idv
GROUP BY V.idv, villearr, prix
HAVING prix IS NULL

-- 6
SELECT COALESCE(categorie, 'SANS'), COUNT(*) AS "Nombre"
FROM tp1_bd_voyage.client
GROUP BY categorie

-- 7
SELECT V.idv, villearr, COUNT(*) AS "Nb reservations", SUM(nbpers) AS "Nb personnes"
FROM tp1_bd_voyage.voyage V
INNER JOIN tp1_bd_voyage.planning P ON V.idv = P.idv
INNER JOIN tp1_bd_voyage.reservation R ON P.idv = R.idv AND P.datedep = R.datedep
GROUP BY V.idv, villearr

-- 8
SELECT V.idv, AVG(prix) AS "Prix moyen"
FROM tp1_bd_voyage.voyage V
INNER JOIN (
  SELECT idv, COALESCE(prix, 0) AS "prix"
  FROM tp1_bd_voyage.carac
) C ON V.idv = C.idv
GROUP BY V.idv

-- 9
SELECT ville, COUNT(*) AS "Nombre"
FROM tp1_bd_voyage.client
GROUP BY ville
HAVING COUNT(*) > 5

-- 10
SELECT V.idv, paysarr, SUM(tarif) AS "Montant total"
FROM tp1_bd_voyage.client C
INNER JOIN tp1_bd_voyage.reservation R ON C.numcl = R.numcl
INNER JOIN tp1_bd_voyage.planning P ON R.idv = P.idv AND R.datedep = P.datedep
INNER JOIN tp1_bd_voyage.voyage V ON P.idv = V.idv
GROUP BY V.idv, paysarr

-- 11
SELECT nom, prenom, V.idv, P.datedep, SUM(tarif) AS "Montant total"
FROM tp1_bd_voyage.client C
INNER JOIN tp1_bd_voyage.reservation R ON C.numcl = R.numcl
INNER JOIN tp1_bd_voyage.planning P ON R.idv = P.idv AND R.datedep = P.datedep
INNER JOIN tp1_bd_voyage.voyage V ON P.idv = V.idv
GROUP BY nom, prenom, V.idv, P.datedep

-- 12
SELECT paysarr, COUNT(*) AS "reservations"
FROM tp1_bd_voyage.reservation R
INNER JOIN tp1_bd_voyage.planning P ON R.idv = P.idv AND R.datedep = P.datedep
INNER JOIN tp1_bd_voyage.voyage V ON P.idv = V.idv
GROUP BY paysarr
HAVING COUNT(*) > (
  SELECT COUNT(*)
  FROM tp1_bd_voyage.reservation R
  INNER JOIN tp1_bd_voyage.planning P ON R.idv = P.idv AND R.datedep = P.datedep
  INNER JOIN tp1_bd_voyage.voyage V ON P.idv = V.idv
  WHERE paysarr = 'ESPAGNE'
)

-- 13
SELECT categorie, COUNT(*) AS "Nombre"
FROM tp1_bd_voyage.client
GROUP BY categorie
HAVING COUNT(*) <= ALL (
  SELECT COUNT(*)
  FROM tp1_bd_voyage.client
  GROUP BY categorie
)

-- 14
SELECT paysarr, COUNT(*) AS "Nombre"
FROM tp1_bd_voyage.reservation R
INNER JOIN tp1_bd_voyage.planning P ON R.idv = P.idv AND R.datedep = P.datedep
INNER JOIN tp1_bd_voyage.voyage V ON P.idv = V.idv
GROUP BY paysarr
HAVING COUNT(*) >= ALL (
  SELECT COUNT(*)
  FROM tp1_bd_voyage.reservation R
  INNER JOIN tp1_bd_voyage.planning P ON R.idv = P.idv AND R.datedep = P.datedep
  INNER JOIN tp1_bd_voyage.voyage V ON P.idv = V.idv
  GROUP BY paysarr, V.idv, P.datedep
)
