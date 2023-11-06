(define (cons a b)
  (* (expt 2 a)
     (expt 3 b)))

(define (multiplicity p n)
  (define (divides? d x)
    (= 0 (remainder x d)))
  (define (iter p n counter)
    (if (divides? p n)
        (iter p (/ n p) (+ counter 1))
        counter))
  (iter p n 0))

(define (car n)
  (multiplicity 2 n))

(define (cdr n)
  (multiplicity 3 n))
