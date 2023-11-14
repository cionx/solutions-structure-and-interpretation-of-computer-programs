# Exercise 2.56

> Show how to extend the basic differentiator to handle more kinds of expressions.
> For instance, implement the differentiation rule
> $$
>   \frac{\mathrm{d} (u^n)}{\mathrm{d} x}
>   = n u^{n-1} \Bigl( \frac{\mathrm{d} u}{\mathrm{d} x} \Bigr)
> $$
> by adding a new clause to the `deriv` program and defining appropriate procedures `exponentiation?`, `base`, `exponent`, and `make-exponentiation`.
> (You may use the symbol `**` to denote exponentiation.)
> Build in the rules that anything raised to the power $0$ is $1$ and anything raised to the power $1$ is the thing itself.

---

We add the following lines to `deriv`:
```scheme
        ((power? expr)
         (let ((b (base expr))
               (n (exponent expr)))
           (make-product (make-product n (make-power b (- n 1)))
                         (deriv b var)))))
```
We thus get overall the following procedure:
```scheme
(define (deriv expr var)
  (cond ((number? expr) 0)
        ((variable? expr)
         (if (same-variable? expr var) 1 0))
        ((sum? expr)
         (make-sum (deriv (addend expr) var)
                   (deriv (augend expr) var)))
        ((product? expr)
         (make-sum
          (make-product (multiplier expr)
                        (deriv (multiplicand expr) var))
          (make-product (deriv (multiplier expr) var)
                        (multiplicand expr))))
        ((power? expr)
         (let ((b (base expr))
               (n (exponent expr)))
           (make-product n (make-product (make-power b (- n 1))
                                         (deriv b var)))))
        (else
          (error "unknown expression type: DERIV" expr))))
```

The constructors and selectors for exponentiation are defined as follows:
```scheme
(define (make-power base exponent)
  (cond ((= exponent 0) 1)
        ((= exponent 1) base)
        ((number? base) (expt base exponent))
        (else (list '** base exponent))))

(define (power? expr)
  (and (pair? expr) (eq? (car expr) '**)))

(define (base e)
  (cadr e))

(define (exponent e)
  (caddr e))
```
