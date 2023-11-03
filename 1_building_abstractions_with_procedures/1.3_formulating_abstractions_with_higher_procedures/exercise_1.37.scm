;;; Recursive solution.

(define (cont-frac n d k)
  (define (aux n d i k)
    (if (> i k)
        0.
        (/ (n i)
           (+ (d i)
              (aux n d (+ 1 i) k)))))
  (aux n d 1 k))

;;; Iterative solution.

(define (cont-frac n d k)
  (define (aux n d i result)
    (if (<= i 0)
        result
        (let ((next-result
                (/ (n i)
                   (+ (d i)
                      result))))
          (aux n d (- i 1) next-result))))
  (aux n d k 0.0))

;;; For calculating 1/ϕ.

(define (one-over-phi k)
  (cont-frac (lambda (i) 1.0)
             (lambda (i) 1.0)
             k))
