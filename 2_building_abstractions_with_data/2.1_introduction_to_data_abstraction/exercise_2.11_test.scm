(load "exercise_2.11.scm")

(define (mul-interval-old x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))

(define (eq-interval? x y)
  (and (= (lower-bound x) (lower-bound y))
       (= (upper-bound x) (upper-bound y))))

(define (old a b c d)
  (let ((x (make-interval a b))
        (y (make-interval c d)))
    (mul-interval-old x y)))

(define (new a b c d)
  (let ((x (make-interval a b))
        (y (make-interval c d)))
    (mul-interval x y)))

(define (same-mul? a b c d)
  (eq-interval? (new a b c d) (old a b c d)))

;; All tests should print #t.
(newline) (display (same-mul?  2  5  1  3)) ; positive, positive
(newline) (display (same-mul?  2  5 -1  3)) ; positive, mixed
(newline) (display (same-mul?  2  5 -3 -1)) ; positive, negative
(newline) (display (same-mul? -2  5  1  3)) ; mixed, positive
(newline) (display (same-mul? -2  5 -1  3)) ; mixed, mixed
(newline) (display (same-mul? -2  5 -3 -1)) ; mixed, negative
(newline) (display (same-mul? -5 -2  1  3)) ; negative, positive
(newline) (display (same-mul? -5 -2 -1  3)) ; negative, mixed
(newline) (display (same-mul? -5 -2 -3 -1)) ; negative, negative
