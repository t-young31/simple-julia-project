#=
InvertMatrix:
- Julia version: 
- Author: tom
- Date: 2022-04-06
=#
using InvertMatrix


function load_matrix(filename::String)::Array{Float64}

    values = Vector{Float64}([])
    lines = readlines(filename)

    for (i, line) in enumerate(lines)
        for item in split(line, " ")
            push!(values, parse(Float64, item))
        end
    end

    ensure_values_can_be_cast_to_square_matrix(values)

    n = length(values) ÷ 2   # Matrix will be nxn

    return reshape(values, (n, n))
end


function ensure_values_can_be_cast_to_square_matrix(values::Vector)

    if length(values) == 0 || length(values) % 2 != 0
        throw(ErrorException("Failed to load a matrix. No elements or not square"))
    end
end


function main()

    if length(ARGS) == 0
        throw(ErrorException("Cannot invert a matrix. No filename given"))
    end

    m = load_matrix(ARGS[1])
    display("text/plain", invert_matrix(m))
    println()

end

main()
