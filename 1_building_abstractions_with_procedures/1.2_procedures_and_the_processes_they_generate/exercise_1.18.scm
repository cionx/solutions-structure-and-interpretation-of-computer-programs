(load "../../sicplib.scm")

(define (double n)
  (+ n n))

(define (halve n)
  (/ n 2))

(define (dec n)
  (- n 1))

;; The expression s + a * b is an invariant.
(define (*-fast-iter s a b)
  (cond ((= b 0) s)
        ((even? b)
         (*-fast-iter s (double a) (halve b)))
        (else
         (*-fast-iter (+ s a) a (dec b)))))

(define (*-fast a b)
  (if (< b 0)
      (*-fast (- a) (- b))
      (*-fast-iter 0 a b)))
