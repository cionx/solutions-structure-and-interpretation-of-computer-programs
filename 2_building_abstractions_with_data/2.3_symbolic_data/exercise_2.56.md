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


We add the following lines to `deriv`:
```scheme
        ((exponentiation? exp)
         (let ((b (base exp))
               (n (exponent exp)))
           (make-product n (make-product
                            (make-exponentiation b (- n 1))
                            (deriv b var)))))
```

The constructors and selectors are defined as follows:
```scheme
(define (make-exponentiation b n)
  (cond ((= n 0) 1)
        ((= n 1) b)
        ((number? b) (expt b n))
        (else (list '** b n))))

(define (exponentiation? expr)
  (and (pair? expr)
       (eq? (car expr) '**)))

(define (base e) (cadr e))

(define (exponent e) (caddr e))
```
