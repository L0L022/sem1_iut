function A = echange_ligne(A, ligne_1, ligne_2)
    [ligne_max, colonne_max] = size(A)
    for colonne = 1 : colonne_max
        tmp = A(ligne_1, colonne)
        A(ligne_1, colonne) = A(ligne_2, colonne)
        A(ligne_2, colonne) = tmp
    end
endfunction

function A = transvection(A, ligne_dest, ligne_src, coef)
    [ligne_max, colonne_max] = size(A)
    for colonne = 1 : colonne_max
        A(ligne_dest, colonne) = A(ligne_dest, colonne) + coef * A(ligne_src, colonne)
    end
endfunction

function pivot_ligne = pivot(A, debut)
    pivot_ligne = debut
    pivot_valeur = abs(A(debut, debut))
    [ligne_max, colonne_max] = size(A)
    for ligne = debut : ligne_max
        if abs(A(ligne, debut)) > pivot_valeur then
            pivot_ligne = ligne
            pivot_valeur = abs(A(ligne, debut))
        end
    end
endfunction

function [A, B] = gauss(A, B)
    [ligne_max, colonne_max] = size(A)
    diagonale_max = ligne_max
    for i_diagonale = 1 : diagonale_max
        pivot_ligne = pivot(A, i_diagonale)
        pivot_valeur = A(pivot_ligne, i_diagonale)
        A = echange_ligne(A, i_diagonale, pivot_ligne)
        B = echange_ligne(B, i_diagonale, pivot_ligne)
        for i_ligne = i_diagonale + 1 : diagonale_max
            coef = - A(i_ligne, i_diagonale) / pivot_valeur
            A = transvection(A, i_ligne, i_diagonale, coef)
            B = transvection(B, i_ligne, i_diagonale, coef)
        end
    end
endfunction
