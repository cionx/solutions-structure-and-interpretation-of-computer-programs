(load "exercise_2.12.scm")

(define x (make-center-percent 6.8 10))

(newline)
(display "Interval: ")
(display x)
(display " vs ")
(display "(6.12, 7.48)")

(newline)
(display "Center: ")
(display (center x))
(display " vs ")
(display 6.8)

(newline)
(display "Percentage: ")
(display (percentage x))
(display " vs ")
(display 10)

(newline)
