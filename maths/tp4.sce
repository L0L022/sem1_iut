/////////////////////////////////////////
//
// M1202 - TP4
//
/////////////////////////////////////////


// Exercice 1 --- Fonctions code et décode
function tab = code(str)
    tab = ascii(str) - ascii("A")
endfunction

function tab = decode(str)
    tab = ascii(str + ascii("A"))
endfunction

// Exercice 2 ---

// 1) Les 2 premières lettres sont chiffrés :
XM

// 2) Fonction chiffre_hill

function mess_chiffre = chiffre_hill(mess_clair)
    A = [9 5;4 7]
    if modulo(length(mess_clair), 2) <> 0 then
        mess_clair=mess_clair+"Z"
    end
    tab = code(mess_clair)
    nvtab = []
    for i = 1 : 2 : length(mess_clair)
        x = A(1, 1) * tab(i) + A(1, 2) * tab(i + 1)
        y = A(2, 1) * tab(i) + A(2, 2) * tab(i + 1)
        disp(tab(i))
        disp(tab(i+1))
        nvtab = [nvtab [modulo(x, 26)] [modulo(y, 26)]]
    end
    mess_chiffre = decode(nvtab)
endfunction

// 3) Test :

XMHCCEGCFICEANGIRFPPWMMGCEWXEKYYJWQTFJ

// Exercice 3 --- Incerse de A
//
//
//	A^{-1} = (1/43) *
//
//


// Exercice 4

// 1) Fonction inverse :

// 2) et 3)

// 4) Fonction dechiffre_hill

// 5) message dechiffré :
//
//
//
//




// Exercice 5
//
//
//

