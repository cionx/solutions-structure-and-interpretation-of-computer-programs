# Exercise 2.75

> Implement the constructor `make-from-mag-ang` in message-passing style.
> This procedure should be analogous to the `make-from-real-imag` procedure given above.



We can write the constructor `make-from-mag-ang` as follows:
```scheme
(define (make-from-mag-ang r a)
  (define (dispatch op)
    (cond ((eq? op 'real-part) (* r (cos a)))
          ((eq? op 'imag-part) (* r (sin a)))
          ((eq? op 'magnitude) r)
          ((eq? op 'angle) a)
          (else error "Unknown op: MAKE-FROM-MAG-ANG")))
  dispatch)
```
