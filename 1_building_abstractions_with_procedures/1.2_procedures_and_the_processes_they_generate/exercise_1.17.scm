(define (double n)
  (+ n n))

(define (halve n)
  (/ 2 n))

(define (dec n)
  (- n 1))

(define (even? n)
  (= n (double (halve n))))

; The expression s + a * b is invariant.
(define (*-fast-iter s a b)
  (cond ((= b 0) s)
        ((even? b)
         (*-fast-iter s (double a) (halve b)))
        (else
         (*-fast-iter (+ s a) a (dec b)))))

(define (*-fast a b)
  (*-fast-iter 0 a b))
