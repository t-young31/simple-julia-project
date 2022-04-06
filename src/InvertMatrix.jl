module InvertMatrix

"""
    invert_matrix(m)

Invert a square matrix

# Examples
```julia-repl
julia> invert_matrix([2., 0; 0, 1])
0.5, 0;
0,   1
```
"""
function invert_matrix(m::Array{Float64})::Array{Float64}

    if !is_square(m)
        throw(DomainError("Cannot invert a non-square matrix"))
    end

    # aug_m = zeros(Float64, m.)

    return m
end


function is_square(m::Array)
    n_rows, n_cols = size(m)
    return n_rows == n_cols
end




#=
ensure_square(m.nrows(), m.ncols());

    let (n_rows, n_cols) = (m.nrows(), m.ncols());

    let mut tmp_m = Array2::<f64>::zeros((n_rows, 2 * n_cols));

    /* Initial augmentation on the RHS diagonal

            (0  0  0  0 ..)         (0  0  1  0 ..)
    tmp_m = (0  0  0  0 ..)   -->   (0  0  0  1 ..)
            (.  .  .  .   )         (.  .  .  . ..)
    */
    for i in 0..n_rows{
        tmp_m[[i, i+n_rows]] = 1.0;
    }

    // Set the LHS as the matrix to invert
    for i in 0..n_rows{

        if is_close(m[[i, i]], 0.0, 1E-8){
            panic!("Cannot invert a matrix with a zero on the diagonal");
        }

        for j in 0..n_cols{
            tmp_m[[i, j]] = m[[i, j]].clone();
        }// j
    }// i

    // And apply the Gauss-Jordan method O(n^3)
    for i in 0..n_rows{
        for j in 0..n_cols{

            if i == j{
                continue;
            }

            let ratio = tmp_m[[j, i]] / tmp_m[[i, i]];

            for k in 0..2*n_cols{
                tmp_m[[j, k]] -= ratio * tmp_m[[i, k]];
            }// k
        }// j
    }// i

    for i in 0..n_rows{
        let tmp_m_ii = tmp_m[[i, i]].clone();

        for j in 0..2*n_cols{
            tmp_m[[i, j]] = tmp_m[[i, j]] / tmp_m_ii;
        }// j
    }// i

    // Finally set the elements of the inverse matrix
    let mut inv = Array2::<f64>::zeros((n_rows, n_cols));

    for i in 0..n_rows{
        for j in n_cols..2*n_cols{
            inv[[i, j-n_cols]] = tmp_m[[i, j]];
        }// j
    }// i

    inv
=#
end # module