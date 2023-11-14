(load "exercise_2.56.scm")

(define (test-function f)
  (newline)
  (display "f:     ")
  (display f)
  (newline)
  (display "df/dx: ")
  (display (deriv f 'x))
  (newline))

(test-function (make-power 'x 1))
(test-function (make-power '(+ x y) 2))
(test-function (make-power '(* x y) 3))
