(define (sub-interval x y)
  (make-interval (- (lower-bound x) (upper-bound y))
                 (- (upper-bound x) (lower-bound y))))



(define (negative x)
  (make-interval (- (upper-bound x))
                 (- (lower-bound x))))

(define (sub-interval x y)
  (add-interval x (negative y)))
