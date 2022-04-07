#=
Test matrix inversion:
- Julia version: 1.7.2
- Author: tom
- Date: 2022-04-06
=#
using InvertMatrix, Test


is_very_close(a, b) = fnorm(a - b) ≈ 0.0

is_close(a, b) = fnorm(a - b) < 1e-4


# Ensure tensors with rank != 2 are handled
@test_throws DomainError invert_matrix([0. 1.])

# Ensure non-square matricies are handled correctly
@test_throws DomainError invert_matrix(ones(Float64, 2, 3))
@test_throws DomainError invert_matrix(ones(Float64, 6, 3))

# Ensure the Frobenius Norm calculation is working correctly
@test fnorm(zeros(Float64, 2, 2)) ≈ 0.0
@test fnorm(I(2) - I(2)) ≈ 0.0

# Identity matrix is self inverse
@test is_very_close(invert_matrix(I(2)),
                    I(2))

# Cannot invert a matrix with zeros on the diagonal
@test_throws MethodError invert_matrix(zeros(Float64, 2, 2))

# Simple diagonal matrix inverse is inverse only of the diagonal elements
@test is_very_close(invert_matrix([2. 0.; 0. 1.]),
                    [0.5 0.; 0. 1.])

@test is_close(invert_matrix(
[0.22578358 -0.10822583  0.34713676
 -0.02490859  0.96449138 -0.32320562
  0.39756888  0.35949152  0.3806542]),
[-34.01143238 -11.68056168  21.09892702
  8.37500355   3.6638014  -4.52670791
  27.61336755   8.73948663 -15.13437572])

println("Tests passed!")
