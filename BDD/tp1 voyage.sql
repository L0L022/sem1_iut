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
WHERE '2003-03-01' <= dateres AND dateres <= '2004-01-01'
-- ou
SELECT R.numcl, idv
FROM tp1_bd_voyage.client C
INNER JOIN tp1_bd_voyage.reservation R ON C.numcl = R.numcl
WHERE dateres BETWEEN '2003-03-01' AND '2004-01-01'

-- 6
SELECT idv, duree
FROM tp1_bd_voyage.voyage
WHERE voyage.paysarr = 'MAROC'
INTERSECT
SELECT idv, duree
FROM tp1_bd_voyage.voyage
WHERE hotel = 'ANTIQUE'

-- 7
SELECT villedep
FROM tp1_bd_voyage.voyage
WHERE paysarr = 'MAROC'

-- sous requetes et operateurs ensemblistes

-- 1
SELECT V1.idv, villearr, tarif
FROM tp1_bd_voyage.voyage V1
INNER JOIN tp1_bd_voyage.planning P ON V1.idv = P.idv
GROUP BY V1.idv, villearr, tarif
HAVING tarif >= ALL(
  SELECT tarif
  FROM tp1_bd_voyage.voyage V2
  INNER JOIN tp1_bd_voyage.planning P ON V2.idv = P.idv
  WHERE V1.idv = V2.idv
)
ORDER BY tarif DESC
--ou


-- 2
SELECT villearr, tarif
FROM tp1_bd_voyage.voyage V
INNER JOIN tp1_bd_voyage.planning P ON V.idv = P.idv
GROUP BY V.idv, villearr, tarif
HAVING tarif >= ALL(
  SELECT tarif
  FROM tp1_bd_voyage.voyage V
  INNER JOIN tp1_bd_voyage.planning P ON V.idv = P.idv
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
-- ou
SELECT V.idv, V.villedep, V.paysarr
FROM tp1_bd_voyage.voyage V
WHERE idv NOT IN (
  SELECT V.idv
  FROM tp1_bd_voyage.voyage V
  INNER JOIN tp1_bd_voyage.planning P ON V.idv = P.idv
  INNER JOIN tp1_bd_voyage.reservation R ON P.idv = R.idv AND P.datedep = R.datedep
)
-- ou
SELECT V.idv, V.villedep, V.paysarr
FROM tp1_bd_voyage.voyage V
WHERE idv <> ALL (
  SELECT V.idv
  FROM tp1_bd_voyage.voyage V
  INNER JOIN tp1_bd_voyage.planning P ON V.idv = P.idv
  INNER JOIN tp1_bd_voyage.reservation R ON P.idv = R.idv AND P.datedep = R.datedep
)

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
