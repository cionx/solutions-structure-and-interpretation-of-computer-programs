# Exercise 2.6

> In case representing pairs as procedures wasn’t mind-boggling enough, consider that, in a language that can manipulate procedures, we can get by without numbers (at least insofar as nonnegative integers are concerned) by implementing $0$ and the operation of adding $1$ as
> ```scheme
> (define zero (lambda (f) (lambda (x) x)))
>
> (define (add-1 n)
>   (lambda (f) (lambda (x) (f ((n f) x)))))
> ```
> This representation is known as _Church numerals_, after its inventor, Alonzo Church, the logician who invented the λ-calculus.
>
> Define `one` and `two` directly (not in terms of `zero` and `add-1`).
> (Hint:
> Use substitution to evaluate `(add-1 zero)`).
> Give a direct definition of the addition procedure `+` (not in terms of repeated application of `add-1`).

---

Let us denote the $n$th Church numeral as $Λ_n$.
According to the given code, the Church numerals are higher-order functions, recursively defined as
$$
  Λ_0(f)(x) = x \,,
  \quad
  Λ_{ν(n)}(f)(x) = f( Λ_n(f)(x) ) \,,
$$
where $ν$ is the successor function of the natural numbers.
We see from that $Λ_n(f)$ is given by the $n$-fold composite $f^n = f ∘ \dotsb ∘ f$ for every $n ≥ 0$, where (as usual) $f^0$ is the identity function.
In other words,
$$
  Λ_n(f) = f^n
  \qquad
  \text{for every $f$ and every $n ≥ 0$} \,.
$$

Explicit descriptions of the first few Church numerals are therefore as follows:
```scheme
(define (zero f)
  (lambda (x) x))

(define (one f)
  (lambda (x) (f x)))

(define (two f)
  (lambda (x) (f (f x))))

(define (three f)
  (lambda (x) (f (f (f x)))))

(define (four f)
  (lambda (x) (f (f (f (f x))))))

(define (five f)
  (lambda (x) (f (f (f (f (f x)))))))
```

We observe that
$$
  Λ_m(f) ∘ Λ_n(f)
  =
  f^m ∘ f^n
  =
  f^{m + n}
  =
  Λ_{m + n}(f) \,.
$$
We can therefore implement addition in terms of composition:
```scheme
(define (add-church m n)
  (lambda (f)
    (lambda (x)
      ((m f) ((n f) x)))))
```

We similarly observe that
$$
  Λ_m( Λ_n(f) )
  =
  Λ_m( f^n )
  =
  (f^n)^m
  =
  f^{m n} \,,
$$
and thus $Λ_m ∘ Λ_n = Λ_{m n}$.
We can therefore implement multiplication as follows:
```scheme
(define (mult-church m n)
  (lambda (f) (m (n f))))
```

Lastly, we observe that
$$
  Λ_m( Λ_n )
  =
  Λ_n^m
  =
  \underbrace{ Λ_n ∘ \dotsb ∘ Λ_n }_m
  =
  Λ_{\underbrace{n \dotsm n}_m}
  =
  Λ_{n^m} \,.
$$
We can therefore implement exponentiation as follows:
```scheme
(define (expt-church m n)
  (lambda (f) ((n m) f)))
```

To test our functions, we use the following procedures to convert between Church numerals and integers:
```scheme
(define (int->church n)
  (define (repeated f n)
    (if (= n 0)
        (lambda (x) x)
        (lambda (x) ((repeated f (- n 1)) (f x)))))
  (lambda (f) (repeated f n)))

(define (church->int n)
  (define (inc x) (+ x 1))
  ((n inc) 0))
```

We can observe the following results:
```text
1 ]=> (church->int (add-church four five))

;Value: 9

1 ]=> (church->int (mult-church three four))

;Value: 12

1 ]=> (church->int (expt-church two five))

;Value: 32

1 ]=> (church->int (int->church 5))

;Value: 5

1 ]=> (church->int (mult-church (int->church 7) (int->church 8)))

;Value: 56
```
