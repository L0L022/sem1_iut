#1
SELECT nomclient, adrclient, cpclient, villeclient, telclient
FROM clients
WHERE nomclient LIKE '_A_IN%'

#2
SELECT numcmde
FROM clients
INNER JOIN commandes ON clients.codeclient = commandes.codeclient
WHERE nomclient = 'RABIN'

#3
SELECT DISTINCT designation
FROM clients
INNER JOIN commandes ON clients.codeclient = commandes.codeclient
INNER JOIN lignes_commande on commandes.numcmde = lignes_commande.numcmde
INNER JOIN produits on lignes_commande.ref = produits.ref
WHERE nomclient = 'RABIN'

#4
SELECT SUM(totht) AS "Montant HT des cdes de Rabin"
FROM clients
INNER JOIN commandes ON clients.codeclient = commandes.codeclient
WHERE nomclient = 'RABIN'

#5
SELECT SUM(lignes_commande.qtdemande*produits.puht) AS "Montant HT Hors transports des cdes de Rabin"
FROM clients
INNER JOIN commandes ON clients.codeclient = commandes.codeclient
INNER JOIN lignes_commande on commandes.numcmde = lignes_commande.numcmde
INNER JOIN produits on lignes_commande.ref = produits.ref
WHERE nomclient = 'RABIN'

#6
SELECT SUM(totht+tottva) AS "CA Octobre 1998"
FROM commandes
WHERE '1998-10-01' <= datecmde AND datecmde <= '1998-10-30'

#7
SELECT SUM(totht+tottva) AS "CA Baudot Marc"
FROM commandes
INNER JOIN vendeurs ON commandes.codevendeur = vendeurs.codevendeur
WHERE nomvendeur = 'BAUDOT' AND prevendeur = 'Marc'
AND '1998-10-01' <= datecmde AND datecmde <= '1998-10-30'

#8
SELECT designation, (1000*puht)/(qte*poidspiece) AS "Prix au kilo", puht AS "Prix du sachet", qte*poidspiece AS "Poids du sachet"
FROM produits
WHERE descriptif = 'P'
ORDER BY "Prix au kilo"
