//ex3
function B = diagonale(A)
    [y_max, x_max] = size(A)
    for x = 1 : x_max
        for y = 1 : y_max
            if x = y then
                B(y, x) = A(y, x)
            else
                B(y, x) = 0
            end
        end
    end
endfunction

//ex4
function B = transpose(A)
    [y_max, x_max] = size(A)
    for x = 1 : x_max
        for y = 1 : y_max
            B(x, y) = A(y, x)
        end
    end
endfunction

//ex5
function [val, i_min, j_min] = minimum(A)
    val=A(1, 1)
    [y_max, x_max] = size(A)
    for x = 1 : x_max
        for y = 1 : y_max
            if A(y, x) < val then
                val = A(y, x)
                i_min = y
                j_min = x
            end
        end
    end
endfunction

//ex6
function res = symetrique(A)
    res = %F;
    if A == transpose(A) then
        res = %T
    end
endfunction

//ex7
function res = antisymetrique(A)
    res = %F
    if -A == transpose(A) then
        res = %T
    end
endfunction

//ex8
function [A1, A2] = decompose(A)
    A1 = 0.5*(A+transpose(A))
    A2 = 0.5*(A-transpose(A))
endfunction

//ex9
function B = permute_colonnes(A)
    [y_max, x_max] = size(A)
    for x = 1 : x_max
        for y = 1 : y_max
            B(y, x_max-x+1) = A(y, x)
        end
    end
endfunction


function B = permute_lignes(A)
    [y_max, x_max] = size(A)
    for x = 1 : x_max
        for y = 1 : y_max
            B(y_max-y+1, x) = A(y, x)
        end
    end
endfunction
