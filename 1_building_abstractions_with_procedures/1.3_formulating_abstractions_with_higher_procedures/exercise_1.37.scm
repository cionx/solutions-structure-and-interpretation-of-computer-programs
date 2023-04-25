(define (cont-frac n d k)
  (define (aux n d i k)
    (if (> i k)
        0.
        (/ (n i)
           (+ (d i)
              (aux n d (+ 1 i) k)))))
  (aux n d 1 k))

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

(define (one-over-phi k)
  (cont-frac (lambda (i) 1.0)
             (lambda (i) 1.0)
             k))
