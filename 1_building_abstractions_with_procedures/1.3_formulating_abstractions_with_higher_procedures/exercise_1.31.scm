(load "../../sicplib.scm")

;; recursive version
(define (product term a next b)
  (if (> a b)
      1
      (* (term a)
         (product term (next a) next b))))

;; iterative version
(define (product term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (* result (term a)))))
  (iter a 1))

(define (factorial n)
  (product identity 1 inc n))

(define (pi-approx n)
  (define (factor k)
    (/ (* k (+ k 2.0))
       (* (+ k 1) (+ k 1))))
  (define (inc-2 x)
    (+ 2 x))
  (* 4 (product factor 2 inc-2 (* 2 n))))
