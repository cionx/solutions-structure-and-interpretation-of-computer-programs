# Exercise 2.77

> Louis Reasoner tries to evaluate the expression `(magnitude z)` where `z` is the object shown in Figure 2.24.
> To his surprise, instead of the answer 5 he gets an error message from `apply-generic`, saying there is no method for the operation `magnitude` on the types `(complex)`.
> He shows this interaction to Alyssa P. Hacker, who says “The problem is that the complex-number selectors were never defined for `complex` numbers, just for `polar` and `rectangular` numbers.
> All you have to do to make this work is add the following to the `complex` package:”
> ```scheme
> (put 'real-part '(complex) real-part)
> (put 'imag-part '(complex) imag-part)
> (put 'magnitude '(complex) magnitude)
> (put 'angle '(complex) angle)
> ```
> Describe in detail why this works.
> As an example, trace through all the procedures called in evaluating the expression `(magnitude z)` where `z` is the object shown in Figure 2.24.
> In particular, how many times is `apply-generic` invoked?
> What procedure is dispatched to in each case?



We have two kinds of “generic procedures”:

1.  The following procedures allow for a generic input via `apply-generic`:

    | Procedure   | Internal symbol | Supported input signatures                                                                |
    | :---------- | :-------------- | :---------------------------------------------------------------------------------------- |
    | `real-part` | `'real-part`    | `('rectangular)`                  <br> `('polar)`                                         |
    | `imag-part` | `'imag-part`    | `('rectangular)`                  <br> `('polar)`                                         |
    | `magnitude` | `'magnitude`    | `('rectangular)`                  <br> `('polar)`                                         |
    | `angle`     | `'angle`        | `('rectangular)`                  <br> `('polar)`                                         |
    | `add`       | `'add`          | `('scheme-number 'scheme-number)` <br> `('rational 'rational)` <br> `('complex 'complex)` |
    | `sub`       | `'sub`          | `('scheme-number 'scheme-number)` <br> `('rational 'rational)` <br> `('complex 'complex)` |
    | `mul`       | `'mul`          | `('scheme-number 'scheme-number)` <br> `('rational 'rational)` <br> `('complex 'complex)` |
    | `div`       | `'div`          | `('scheme-number 'scheme-number)` <br> `('rational 'rational)` <br> `('complex 'complex)` |

    The output of these procedures may or may not be generic itself.

2.  The following procedures use `get` to have a generic output, but their input is non-generic:

    | Procedure                                                    | Internal symbol        | Output signature                                           |
    | :----------------------------------------------------------- | :--------------------- | :--------------------------------------------------------- |
    | `make-scheme-number`  <br> `make-rational`                   | `'make`                | `'scheme-number` <br> `'rational`                          |
    | `make-from-real-imag` <br><br> `make-complex-from-real-imag` | `'make-from-real-imag` | `'rectangular`   <br> `'polar`    <br> `'complex`          |
    | `make-from-mag-ang`   <br><br> `make-complex-from-mag-ang`   | `'make-from-mag-ang`   | `'rectangular`   <br> `'polar`    <br> `'complex`          |

We see that the generic procedures `real-part`, `imag-part`, `magnitude` and `angle` are defined for the specific types `'rectangular` and `'polar`, but not for their common supertype `'complex`.

The object `z` is given by `(cons 'complex (cons 'rectangular (cons 3 4)))'`.
It is thus a pair of numbers that is first tagged as `'rectangular`, and then as `'complex`.
The type of `z` is thus `'complex`.

The procedure `magnitude` is implemented in terms of `apply-generic`:
the expression `(magnitude z)` is evaluated to `(apply-generic 'magnitude z)`.
The procedure `apply-generic` then looks up the procedure that is specified under the symbol `'magnitude` for the input signature `('complex)`.
However, as noted above, the only procedures registered under `'magnitude` are those for the input signatures `('rectangular)` and `('polar)`.
Consequently, `apply-generic` triggers an error, whiche reports to us that no suitable procedure could be found.

To fix this problem, we need to register a procedure for `'magnitude` for the type `'complex`.
That is, we need a procedure that computes the magnitude of `⟨content⟩` in `('complex ⟨content⟩)`.
This `⟨content⟩` is either of type `'rectangular` or `'polar`, and the procedure `magnitude` can thankfully already deal with those types.
We hence add the following registration:
```scheme
(put 'magnitude ('complex) magnitude)
```
With this new registration, Louis’s expression will be evaluated as follows:
```scheme
(magnitude (cons 'complex (cons 'rectangular (cons 3 4))))

(apply-generic 'magnitude (cons 'complex (cons 'rectangular (cons 3 4))))

((get 'magnitude ('complex)) (cons 'rectangular (cons 3 4)))
  ;; this is where the new registration is used
(magnitude (cons 'rectangular (cons 3 4)))

(apply-generic 'magnitude (cons 'rectangular (cons 3 4)))

((get 'magnitude ('rectangular)) (cons 3 4))

(⟨internal magnitude procedure of the rectangular package⟩ (cons 3 4))

(sqrt (+ (square 3) (square 4)))

(sqrt (+ 9 (square 4)))

(sqrt (+ 9 16))

(sqrt 25)

5
```

The same discussion holds true for the procedured `real-part`, `imag-part` and `angle` instead of `magnitude`.
