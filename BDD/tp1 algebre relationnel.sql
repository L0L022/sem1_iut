
# A
SELECT *
FROM film
WHERE annee <= '2000-01-01' AND genre != 'Policier';

# B
SELECT *
FROM film
WHERE annee <= '2000-01-01' AND genre = 'Drame';

# C
SELECT DISTINCT genre
FROM film;

# D
SELECT genre
FROM film
WHERE annee < '2000-01-01';

# E
SELECT nom, prenom
FROM individu
WHERE prenom = 'John'
UNION ALL
SELECT nom, prenom
FROM individu
WHERE prenom = 'Paul'

# F
SELECT prenom
FROM individu
INTERSECT
SELECT role
FROM jouer

# G
SELECT titre, genre, nom
FROM film CROSS JOIN cinema
WHERE extract(year from annee)<=1985

# H
SELECT titre, nom, prenom
FROM film F INNER JOIN individu I ON F.num_ind = I.num_ind

# I
SELECT nom
FROM individu
WHERE nom LIKE '%T%' OR nom LIKE '%W%'
EXCEPT
SELECT nom
FROM individu
WHERE prenom = 'John'

# 1
SELECT titre
FROM film
WHERE genre = 'Drame'

# 2
SELECT DISTINCT titre
FROM cinema C
INNER JOIN projection P on C.num_cine = P.num_cine
INNER JOIN film F on P.num_film = F.num_film
WHERE nom = 'Le Fontenelle'

# 3
SELECT nom, prenom
FROM individu
INTERSECT
SELECT nom, prenom
FROM film F INNER JOIN individu I on F.num_ind = I.num_ind

# 4
SELECT nom, prenom
FROM individu
INTERSECT
SELECT nom, prenom
FROM film F
INNER JOIN jouer J on F.num_film = J.num_film
INNER JOIN individu I on J.num_ind = I.num_ind

# 5
SELECT nom, prenom
FROM film F INNER JOIN individu I on F.num_ind = I.num_ind
INTERSECT
SELECT nom, prenom
FROM film F
INNER JOIN jouer J on F.num_film = J.num_film
INNER JOIN individu I on J.num_ind = I.num_ind

# 6
SELECT DISTINCT titre
FROM film F
INNER JOIN projection P on F.num_film = P.num_film
WHERE extract(year from date) = 2002

# 7
SELECT titre
FROM film F
INNER JOIN individu I on F.num_ind = I.num_ind
WHERE nom = 'von Trier' AND prenom = 'Lars'

# 8
SELECT nom, prenom
FROM individu
INTERSECT
SELECT nom, prenom
FROM film F
INNER JOIN individu I on F.num_ind = I.num_ind
WHERE genre = 'Epouvante'
INTERSECT
SELECT nom, prenom
FROM film F
INNER JOIN individu I on F.num_ind = I.num_ind
WHERE genre = 'Drame'

# 9
SELECT DISTINCT F.titre
FROM cinema C
INNER JOIN projection P on C.num_cine = P.num_cine
INNER JOIN film F on P.num_film = F.num_film
INNER JOIN jouer J on F.num_film = J.num_film
INNER JOIN individu I on J.num_ind = I.num_ind
WHERE C.nom = 'Le Fontenelle' AND I.nom = 'Kidman' AND I.prenom = 'Nicole'

# 10
SELECT nom, prenom
FROM film F
INNER JOIN jouer J on F.num_film = J.num_film
INNER JOIN individu I on J.num_ind = I.num_ind
EXCEPT
SELECT nom, prenom
FROM film F
INNER JOIN jouer J on F.num_film = J.num_film
INNER JOIN individu I on J.num_ind = I.num_ind
WHERE genre = 'Drame'

# 11
SELECT nom, prenom
FROM individu
INTERSECT
SELECT I.nom, I.prenom
FROM individu I
INNER JOIN jouer J on I.num_ind = J.num_ind
INNER JOIN film F on J.num_film = F.num_film
INNER JOIN projection P on F.num_film = P.num_film
INNER JOIN cinema C on P.num_cine = C.num_cine
WHERE C.nom = 'Le Fontenelle' AND extract(year from P.date) > 2000

# 12
SELECT DISTINCT titre
FROM film F
INNER JOIN projection P on F.num_film = P.num_film
WHERE P.date - F.annee > 5 * 365
