# Exercise 1.38

> In 1737, the Swiss mathematician Leonhard Euler published a memoir _De Fractionibus Continuis_, which included a continued fraction expansion for $e - 2$, where $e$ is the base of the natural logarithms.
> In this fraction, the $N_i$ are all $1$, and the $D_i$ are successively $1, 2, 1, 1, 4, 1, 1, 6, 1, 1, 8, …$
> Write a program that uses your `cont-frac` procedure from Exercise 1.37 to approximate $e$, based on Euler’s expansion.



We can use the following procedure(s):
```scheme
(define (euler-fraction k)
  (define (n i) 1.0)
  (define (d i)
    (if (= 2 (remainder i 3))
      (* 2 (+ 1 (quotient i 3)))
      1.0))
  (cont-frac n d k))

(define (e-approx k)
  (+ 2.0 (euler-fraction k)))

(define (cont-frac n d k)
  (define (aux n d i result)
    (if (<= i 0)
        result
        (let ((new-result
                (/ (n i) (+ (d i) result))))
          (if (<= i 0)
              result
              (aux n d (- i 1) new-result)))))
  (aux n d k 0.0))
```
