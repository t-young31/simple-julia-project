module InvertMatrix
export invert_matrix, I, fnorm

"""
    invert_matrix(m)

Invert a square matrix

# Examples
```julia-repl
julia> invert_matrix([2. 0.; 0. 1.])
0.5  0;
0    1
```
"""
function invert_matrix(m::Array{Float64})::Array{Float64}

    check_invertable(m)
    n_rows, n_cols = size(m)

    m̄ = right_augmented_with_idenitiy_matrix(m)

    for i=1:n_rows
        for j=1:n_cols
            if i == j
                continue
            end

            tmp = m̄[j, i] / m̄[i, i]

            for k=1:2*n_cols
                m̄[j, k] -= tmp * m̄[i, k]
            end
        end
    end


    for i=1:n_rows
        tmp = m̄[i, i]
        for j=1:2*n_cols
            m̄[i, j] = m̄[i, j] / tmp
        end
    end

    m_inv = zeros(Float64, n_rows, n_cols)

    for i=1:n_rows
        for j=n_cols+1:2*n_cols
            m_inv[i, j-n_cols] = copy(m̄[i, j])
        end
    end

    return m_inv
end


function right_augmented_with_idenitiy_matrix(m::Array{Float64})::Array{Float64}

    if !is_square(m)
        throw(MethodError("Cannot right augment a non square matrix"))
    end

    n_rows, n_cols = size(m)

    aug_m = zeros(Float64, n_rows, 2*n_cols)

    for i=1:n_rows
        aug_m[i, i+n_rows] = 1.0;    # RHS is an identity matrix

        for j=1:n_cols
            aug_m[i, j] = copy(m[i, j])      # LHS is input matrix
        end
    end

    return aug_m
end


function check_invertable(m::Array{Float64})
    if !is_square(m)
        throw(DomainError("Cannot invert a non-square matrix"))
    end

    if has_diagnoal_zeros(m)
        throw(MethodError("Cannot invert a matrix with diagonal zeros"))
    end
end


function has_diagnoal_zeros(m::Array{Float64})

    if (ndims(m) != 2 || size(m, 1) != size(m, 2))
        return false
    end

    for i=1:size(m, 1)
        if m[i, i]  ≈ 0.0
            return true
        end
    end

    return false
end


function is_square(m::Array)
    n_rows, n_cols = size(m)
    return n_rows == n_cols
end


function I(n::Integer)::Array{Float64}

    m = zeros(Float64, n, n)
    for i=1:n
        m[i, i] = 1.0
    end

    return m
end


function fnorm(m::Array{Float64})::Float64

    norm_sq = 0.0   # Square of the Frobenius Norm

    for j in 1:size(m, 2)
        for i in 1:size(m, 1)
            norm_sq += m[i, j]^2
        end
    end

    return sqrt(norm_sq)
end

end # module