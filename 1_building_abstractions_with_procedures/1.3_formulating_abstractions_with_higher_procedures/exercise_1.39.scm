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

(define (tan-cf x k)
  (define (n i)
    (if (= i 1)
        x
        (- (square x))))
  (define (d i)
    (- (* 2 i) 1))
  (cont-frac n d k))



(define (square x)
  (* x x))
