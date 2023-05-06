# Exercise 2.73

> Section 2.3.2 described a program that performs symbolic differentiation:
> ```scheme
> (define (deriv exp var)
>   (cond ((number? exp) 0)
>         ((variable? exp)
>          (if (same-variable? exp var) 1 0))
>         ((sum? exp)
>          (make-sum (deriv (addend exp) var)
>                    (deriv (augend exp) var)))
>         ((product? exp)
>          (make-sum
>           (make-product (multiplier exp)
>                         (deriv (multiplicand exp) var))
>           (make-product (deriv (multiplier exp) var)
>                         (multiplicand exp))))
>         ⟨more rules can be added here⟩
>         (else (error "unknown expression type: DERIV" exp))))
> ```
> We can regard this program as performing a dispatch on the type of the expression to be differentiated.
> In this situation the “type tag” of the datum is the algebraic operator symbol (such as `+`) and the operation being performed is `deriv`.
> We can transform this program into data-directed style by rewriting the basic derivative procedure as
> ```scheme
> (define (deriv exp var)
>   (cond ((number? exp) 0)
>         ((variable? exp)
>          (if (same-variable? exp var) 1 0))
>         (else
>          ((get 'deriv (operator exp)) (operands exp) var))))
>
> (define (operator exp) (car exp))
>
> (define (operands exp) (cdr exp))
> ```
>
> 1.  Explain what was done above.
>     Why can’t we assimilate the predicates `number?` and `variable?` into the data-directed dispatch?
>
> 2.  Write the procedures for derivatives of sums and products, and the auxiliary code required to install them in the table used by the program above.
>
> 3.  Choose any additional differentiation rule that you like, such as the one for exponents (Exercise 2.56), and install it in this data-directed system.
>
> 4.  In this simple algebraic manipulator the type of an expression is the algebraic operator that binds it together.
>     Suppose, however, we indexed the procedures in the opposite way, so that the dispatch line in `deriv` looked like
>     ```scheme
>     ((get (operator exp) 'deriv) (operands exp) var)
>     ```
>     What corresponding changes to the derivative system are required?



### 1.

The exercise already explained itself.

The problem with `number?` and `variable?` is that numbers and variables cannot be regarded as tagged data, since a tagged datum is always a pair whose first entry is a symbol.
We would need to represent numbers as `('number ⟨n⟩)` and variables as `('variable ⟨var⟩)` to incorporate the derivation rules for constants and variables into the general framework of tagged data.



### 2. and 3.

We can rewrite the previous procedures in terms of tagged data as follows:
```scheme
(define (operator exp) (type-tag exp))
(define (operands exp) (contents exp))

(define (make-sum a1 a2)
  (cond ((=number? a1 0) a2)
        ((=number? a2 0) a1)
        ((and (number? a1) (number? a2)) (+ a1 a2))
        (else (attach-tag '+ (list a1 a2)))))
(define (sum? x) (eq? (type-tag x) '+))
(define (addend s) (car (contents s)))
(define (augend s) (cadr (contents s)))

(define (make-product m1 m2)
  (cond ((or (=number? m1 0) (=number? m2 0)) 0)
        ((=number? m1 1) m2)
        ((=number? m2 1) m1)
        ((and (number? m1) (number? m2)) (* m1 m2))
        (else (attach-tag '* (list m1 m2)))))
(define (product? x) (eq? (type-tag x) '*))
(define (multiplier p) (car (contents p)))
(define (multiplicand p) (cadr (contents p)))

(define (make-exponentiation b n)
  (cond ((= n 0) 1)
        ((= n 1) b)
        ((number? b) (expt b n))
        (else (attach-tag '** (list b n)))))
(define (exponentiation? x) (eq? (type-tag x) '**))
(define (base e) (car (contents e)))
(define (exponent e) (cadr (contents e)))
```
We can then use the following code:
```scheme
(define (install-deriv-package)
  ;; internal procedures
  (define (deriv-add expressions var)
    (make-sum (deriv (car expressions) var)
              (deriv (cadr expressions) var)))
  (define (deriv-mul expressions var)
    (let ((exp1 (car expressions))
          (exp2 (cadr expressions)))
      (make-sum
       (make-product exp1 (deriv exp2 var))
       (make-product (deriv exp1 var) exp2))))
  (define (deriv-pow arguments var)
    (let ((base (car arguments))
          (n (cadr arguments)))
      (make-product n (make-product
                       (make-exponentiation base (- n 1))
                       (deriv base var)))))
  ;; interface to the rest of the system
  (put 'deriv '+ deriv-add)
  (put 'deriv '* deriv-mul)
  (put 'deriv '** deriv-pow)
  'done)
```



### 4.

If we change the line
```scheme
((get 'deriv (operator exp)) (operands exp) var))))
```
to the new line
```scheme
((get (operator exp) 'deriv) (operands exp) var)
```
then we need to make the following changes to our installation:
```scheme
(put '+ 'deriv deriv-add)
(put '* 'deriv deriv-mul)
(put '** 'deriv deriv-pow)
```
