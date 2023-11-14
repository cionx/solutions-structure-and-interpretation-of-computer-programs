(load "exercise_2.57.scm")

(define f '(* x y (+ x 3)))

(newline)
(display "f:     ")
(display f)
(newline)
(display "df/dx: ")
(display (deriv f 'x))
(newline)
(display "df/dy: ")
(display (deriv f 'y))
