-- 1
SELECT NomPilote, prenomPilote, NomCircuit
FROM tp_formule1.pilote P
INNER JOIN tp_formule1.courir Co ON P.idpilote = Co.idpilote
INNER JOIN tp_formule1.grandprix G ON Co.idgp = G.idgp
INNER JOIN tp_formule1.circuit Ci ON G.id_circuit = Ci.id_circuit
WHERE positionarrivee = 'A'
ORDER BY nomgp, nompilote

-- 2
SELECT points
FROM tp_formule1.bareme
WHERE place = 2
