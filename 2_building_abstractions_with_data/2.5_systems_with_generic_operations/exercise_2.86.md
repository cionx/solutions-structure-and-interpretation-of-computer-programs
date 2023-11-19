# Exercise 2.86

> Suppose we want to handle complex numbers whose real parts, imaginary parts, magnitudes, and angles can be either ordinary numbers, rational numbers, or other numbers we might wish to add to the system.
> Describe and implement the changes to the system needed to accommodate this.
> You will have to define operations such as `sine` and `cosine` that are generic over ordinary numbers and rational numbers.

---

This exercise doesn’t make much sense to me because of polar coordinates:
working with polar coordinates requires us to work with primitive Scheme numbers because of `sqrt`, `cos` and `sin`.
If we consider only complex numbers whose components are of a specific number type, then we have to coerce these primitive Scheme numbers back into our specific number type.
But we typically have no way of doing so.

For example, suppose that $z_1$ and $z_2$ are complex numbers with rational real parts and imaginary parts.
The product $z_1 ⋅ z_2$ again has rational real part and rational imaginary part.
But computing the product in polar coordinates and then extracting real and imaginary part of this product results in two primitive scheme numbers, which we cannot translate back into rational numbers.

We could avoid this problem by banishing polar coordinates and only dealing with cartesian coordinates.
But this doesn’t seem to be in the spirit of the question.
