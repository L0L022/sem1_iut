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
