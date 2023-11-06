(load "../../sicplib.scm")



;;; First solution.

(define (sub-interval x y)
  (make-interval (- (lower-bound x) (upper-bound y))
                 (- (upper-bound x) (lower-bound y))))



;;; Second solution.

(define (negate-interval x)
  (make-interval (- (upper-bound x))
                 (- (lower-bound x))))

(define (sub-interval x y)
  (add-interval x (negate-interval y)))
