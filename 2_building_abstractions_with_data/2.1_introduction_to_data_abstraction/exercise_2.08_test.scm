(load "exercise_2.08.scm")

(define x (make-interval 5 10))
(define y (make-interval 3 6))

; Result sholud be (-1, 7)
(newline)
(display "(-1, 7): ")
(display (sub-interval x y))
