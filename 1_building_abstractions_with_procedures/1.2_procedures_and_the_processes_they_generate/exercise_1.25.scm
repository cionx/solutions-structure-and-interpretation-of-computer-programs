(load "../../sicplib.scm") ;; for square

(define (expmod-old base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (square (expmod-old base (/ exp 2) m))
                    m))
        (else
         (remainder (* base (expmod-old base (- exp 1) m))
                    m))))

(define (expmod-new base exp m)
  (remainder (fast-expt base exp) m))

(define (fast-expt b n)
  (cond ((= n 0) 1)
        ((even? n) (square (fast-expt b (/ n 2))))
        (else (* b (fast-expt b (- n 1))))))
