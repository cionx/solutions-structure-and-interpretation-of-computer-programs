(define (cont-frac n d k)
  (define (aux n d i result)
    (if (<= i 0)
        result
        (let ((new-result
                (/ (n i) (+ (d i) result))))
          (if (<= i 0)
              result
              (aux n d (- i 1) new-result)))))
  (aux n d k 0.0))

(define (euler-fraction k)
  (define (n i) 1.0)
  (define (d i)
    (if (= 2 (remainder i 3))
        (* 2 (+ 1 (quotient i 3)))
        1.0))
  (cont-frac n d k))

(define (e-approx k)
  (+ 2.0 (euler-fraction k)))
