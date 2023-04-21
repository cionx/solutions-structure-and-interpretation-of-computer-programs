(define (multiplicity p n)
  (define (divides? a b)
    (= 0 (remainder b a)))
  (define (iter p n counter)
    (if (divides? p n)
        (iter p (/ n p) (+ counter 1))
        counter))
  (iter p n 0))

(define (cons a b)
  (* (expt 2 a)
     (expt 3 b)))

(define (car n)
  (multiplicity 2 n))

(define (cdr n)
  (multiplicity 3 n))
