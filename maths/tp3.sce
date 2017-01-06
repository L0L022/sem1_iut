function A = echange_ligne(A, y_1, y_2)
    [y_max, x_max] = size(A)
    for x = 1 : x_max
        tmp=A(y_1, x)
        A(y_1, x)=A(y_2, x)
        A(y_2, x)=tmp
    end
endfunction

function A = transvection(A, y_dest, y_src, coef)
    [y_max, x_max] = size(A)
    for x = 1 : x_max
        A(y_dest, x)=A(y_dest, x)+coef*A(y_src, x)
    end
endfunction

function p = pivot(A, debut)
    p = debut
    p_valeur = abs(A(debut, debut))
    [y_max, x_max] = size(A)
    for y = debut : y_max
        if abs(A(y, debut)) > p_valeur then
            p = y
            p_valeur = abs(A(y, debut))
        end
    end
endfunction

function [A, B] = gauss(A, B)
    [y_max, x_max] = size(A)
    for i_diagonale = 1 : x_max
        p = pivot(A, i_diagonale)
        A = echange_ligne(A, i_diagonale, p)
        for i_y = i_diagonale + 1 : y_max
            //for i_x = 1 : x_max
              // A(i_y, i_x) = A(i_y, i_x)-(A(i_y,i_diagonale)/A(p,p))*A(i_diagonale, i_x)
            //end
            A = transvection(A, i_y, i_diagonale, -A(i_y,i_diagonale)/A(p,p))
        end
    end
endfunction
