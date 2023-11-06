(load "../../sicplib.scm")

(define (mul-interval x y)
  (define (sign-interval z)
    (cond ((<= 0 (lower-bound z)) 1)
          ((<= (upper-bound z) 0) -1)
          (else 0)))
  (let ((x-sign (sign-interval x))
        (y-sign (sign-interval y)))
    (cond
      ;; By commutativity of multiplication we may assume that
      ;;    x-sign >= y-sign.
      ;; Otherwise we swap the factors.
      ((< x-sign y-sign)
       (mul-interval y x))
      ;; Both intervals are positive.
      ((and (= x-sign 1) (= y-sign 1))
       (make-interval (* (lower-bound x) (lower-bound y))
                      (* (upper-bound x) (upper-bound y))))
       ;; x is positive, y is mixed
      ((and (= x-sign 1) (= y-sign 0))
       (make-interval (* (upper-bound x) (lower-bound y))
                      (* (upper-bound x) (upper-bound y))))
      ;; x is positive, y is negative
      ((and (= x-sign 1) (= y-sign -1))
       (make-interval (* (upper-bound x) (lower-bound y))
                      (* (lower-bound x) (upper-bound y))))
      ;; x is mixed, y is mixed
      ((and (= x-sign 0) (= y-sign 0))
       (let ((p1 (* (lower-bound x) (lower-bound y)))
             (p2 (* (lower-bound x) (upper-bound y)))
             (p3 (* (upper-bound x) (lower-bound y)))
             (p4 (* (upper-bound x) (upper-bound y))))
         (make-interval (min p1 p2 p3 p4)
                        (max p1 p2 p3 p4))))
      ;; x is mixed, y is negative
      ((and (= x-sign 0) (= y-sign -1))
       (make-interval (* (upper-bound x) (lower-bound y))
                      (* (lower-bound x) (lower-bound y))))
      ;; x is negative, y is negative
      ((and (= x-sign -1) (= y-sign -1))
       (make-interval (* (upper-bound x) (upper-bound y))
                      (* (lower-bound x) (lower-bound y))))
      ;; We should never reach the following.
      (else (error "Unknown sign combinatin in mult-interval"
                   x-sign
                   y-sign)))))
