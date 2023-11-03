(load "../../sicplib.scm")



;; Recursive version.
(define (accumulate combiner null-value term a next b)
  (if (> a b)
      null-value
      (combiner (term a)
                (accumulate combiner null-value term (next a) next b))))

;; Iterative version.
(define (accumulate combiner null-value term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (combiner result (term a)))))
  (iter a null-value))



(define (sum term a next b)
  (define (add x y)
    (+ x y))
  (accumulate add 0 term a next b))

(define (product term a next b)
  (define (multiply x y)
    (* x y))
  (accumulate multiply 1 term a next b))



;;; For testing.

(define (gauss-sum n)
  (sum identity 1 inc n))

(define (factorial n)
  (product identity 1 inc n))
