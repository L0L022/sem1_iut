-- 1
SELECT NomPilote, prenomPilote, NomCircuit
FROM tp_formule1.pilote P
INNER JOIN tp_formule1.courir Co ON P.idpilote = Co.idpilote
INNER JOIN tp_formule1.grandprix G ON Co.idgp = G.idgp
INNER JOIN tp_formule1.circuit Ci ON G.id_circuit = Ci.id_circuit
WHERE positionarrivee = 'A'
ORDER BY nomgp, nompilote

-- 2
SELECT points AS "si plus de la moitié des tours", (points/2.0)::numeric(3,1) AS "si plus de 2 tours et moins de la moitié des tours"
FROM tp_formule1.bareme

-- 3
SELECT nomgp, nbtour, nbtourseffectue, (nbtourseffectue/nbtour::real) AS "rapport tours réalisés"
FROM tp_formule1.grandprix

-- 4
SELECT nomgp, nbtour*longpiste AS "distance à parcourir"
FROM tp_formule1.grandprix G
INNER JOIN tp_formule1.circuit C ON G.id_circuit = C.id_circuit
ORDER BY "distance à parcourir" DESC

-- 5
SELECT nomgp, nompilote, prenompilote, COALESCE((
  SELECT CASE WHEN nbtourseffectue >= 2 AND nbtourseffectue/nbtour::real < 0.5
            THEN points/2.0
            ELSE points
          END
  FROM tp_formule1.bareme
  WHERE place = positionarrivee::integer
  ), 0) AS "nb points acquis", positionarrivee, (nbtourseffectue/nbtour::real) AS "rapport tours réalisés"
FROM tp_formule1.grandprix G
INNER JOIN tp_formule1.courir C ON G.idgp = C.idgp
INNER JOIN tp_formule1.pilote P ON C.idpilote = P.idpilote
WHERE positionarrivee != 'A' AND positionarrivee::integer > 0
ORDER BY nomgp, positionarrivee::integer

-- 6
SELECT nomgp, nomecurie, SUM(COALESCE((
  SELECT CASE WHEN nbtourseffectue >= 2 AND nbtourseffectue/nbtour::real < 0.5
            THEN points/2.0
            ELSE points
          END
  FROM tp_formule1.bareme
  WHERE place = positionarrivee::integer
  ), 0)) AS "nb points acquis"
FROM tp_formule1.grandprix G
INNER JOIN tp_formule1.courir C ON G.idgp = C.idgp
INNER JOIN tp_formule1.voiture V ON C.numvoiture = V.numvoiture
INNER JOIN tp_formule1.ecurie E ON V.id_ecurie = E.id_ecurie
WHERE positionarrivee != 'A' AND positionarrivee::integer > 0
GROUP BY E.id_ecurie, G.idgp
ORDER BY G.nomgp, "nb points acquis" DESC

-- 7
SELECT P1.idpilote, P1.nompilote, P1.prenompilote, (
  COALESCE((
    SELECT SUM(COALESCE((
      SELECT CASE WHEN nbtourseffectue >= 2 AND nbtourseffectue/nbtour::real < 0.5
                THEN points/2.0
                ELSE points
              END
      FROM tp_formule1.bareme
      WHERE place = CASE WHEN positionarrivee != 'A' AND positionarrivee::integer > 0
                      THEN positionarrivee::integer
                      ELSE 0
                    END
      ), 0))
    FROM tp_formule1.grandprix G
    INNER JOIN tp_formule1.courir C ON G.idgp = C.idgp
    INNER JOIN tp_formule1.pilote P ON C.idpilote = P.idpilote
    WHERE P1.idpilote = P.idpilote
    GROUP BY P.idpilote
), 0)) AS "nb point par pilote"
FROM tp_formule1.pilote P1
ORDER BY "nb point par pilote" DESC

-- 8
SELECT nomecurie, SUM(COALESCE((
  SELECT CASE WHEN nbtourseffectue >= 2 AND nbtourseffectue/nbtour::real < 0.5
            THEN points/2.0
            ELSE points
          END
  FROM tp_formule1.bareme
  WHERE place = positionarrivee::integer
  ), 0)) AS "nb points acquis"
FROM tp_formule1.grandprix G
INNER JOIN tp_formule1.courir C ON G.idgp = C.idgp
INNER JOIN tp_formule1.voiture V ON C.numvoiture = V.numvoiture
INNER JOIN tp_formule1.ecurie E ON V.id_ecurie = E.id_ecurie
WHERE positionarrivee != 'A' AND positionarrivee::integer > 0
GROUP BY E.id_ecurie
ORDER BY "nb points acquis" DESC

-- 9
SELECT nompilote, prenompilote
FROM tp_formule1.pilote
EXCEPT
SELECT nompilote, prenompilote
FROM tp_formule1.grandprix G
INNER JOIN tp_formule1.courir C ON G.idgp = C.idgp
INNER JOIN tp_formule1.pilote P ON C.idpilote = P.idpilote
ORDER BY nompilote
-- ou
-- ou
-- ou

-- 10
SELECT P1.nompilote, P1.prenompilote
FROM tp_formule1.pilote P1
WHERE 2 = (
  SELECT COUNT(*)
  FROM tp_formule1.grandprix G
  INNER JOIN tp_formule1.courir C ON G.idgp = C.idgp
  INNER JOIN tp_formule1.pilote P ON C.idpilote = P.idpilote
  WHERE P.idpilote = P1.idpilote
  GROUP BY P.idpilote
)
ORDER BY P1.nompilote

-- 11
SELECT SUM(nbtourseffectue*longpiste) AS "nb total km"
FROM tp_formule1.grandprix G
INNER JOIN tp_formule1.circuit C ON G.id_circuit = C.id_circuit

-- 12
SELECT P1.nompilote, P1.prenompilote, COALESCE((
  SELECT SUM(nbtourseffectue*longpiste)
  FROM tp_formule1.circuit CI
  INNER JOIN tp_formule1.grandprix G ON CI.id_circuit = G.id_circuit
  INNER JOIN tp_formule1.courir CO ON G.idgp = CO.idgp
  INNER JOIN tp_formule1.pilote P ON CO.idpilote = P.idpilote
  WHERE P.idpilote = P1.idpilote
  GROUP BY P.idpilote
), 0) AS "nb total km par GP"
FROM tp_formule1.pilote P1
ORDER BY "nb total km par GP" DESC

-- 13
