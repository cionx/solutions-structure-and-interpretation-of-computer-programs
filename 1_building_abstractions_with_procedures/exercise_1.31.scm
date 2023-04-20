(define (product term a next b)
  (if (> a b)
      1
      (* (term a)
         (product term (next a) next b))))

(define (product term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (* result (term a)))))
  (iter a 1))

(define (factorial n)
  (define (id x) x)
  (define (inc x) (+ 1 x))
  (product id 1 inc n))

(define (pi-approx n)
  (define (term k)
    (/ (* k (+ 2.0 k))
       (* (+ 1 k) (+ 1 k))))
  (define (inc-2 x) (+ 2 x))
  (* (product term 2 inc-2 (* 2 n))
     4))
