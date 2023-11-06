(load "../../sicplib.scm")



(define (contains-zero? x)
  (and (<= (lower-bound x) 0)
       (<= 0 (upper-bound x))))

(define (div-interval x y)
  (if (contains-zero? y)
      (error "Division by zero in div-interval.")
      (mul-interval x
                    (make-interval (/ 1.0 (upper-bound y))
                                   (/ 1.0 (lower-bound y))))))
