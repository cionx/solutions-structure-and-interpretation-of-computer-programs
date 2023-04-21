(define (mul-interval x y)
  (cond (; one of the intervals is strictly non-negative
         ((or (not (negative? (lower-bound x)))
              (not (negative? (lower-bound y))))
          (make-interval (* (lower-bound x) (lower-bound y))
                         (* (upper-bound x) (upper-bound y))))
         ; one of the intervals is strictly non-positive
         ((or (not (positive? (upper-bound x)))
              (not (positive? (upper-bound y))))
          (make-interval (* (lower-bound x) (upper-bound y))
                         (* (upper-bound x) (lower-bound y))))
         ; both intervals have a neg. lower bound and pos. upper bound
         (else (let ((p1 (* (upper-bound x) (upper-bound y)))
                     (p2 (* (lower-bound x) (lower-bound y)))
                     (n1 (* (upper-bound x) (lower-bound y)))
                     (n2 (* (lower-bound x) (upper-bound y))))
                 (make-interval (min n1 n2) (max p1 p2)))))))
