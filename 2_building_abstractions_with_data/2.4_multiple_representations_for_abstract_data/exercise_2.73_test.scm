(load "exercise_2.73.scm")



(install-deriv-package)

(define f '(+ (** x 2) (* 3 x)))

(newline)
(display "f:     ")
(display f)
(newline)
(display "df/dx: ")
(display (deriv f 'x))
(newline)
