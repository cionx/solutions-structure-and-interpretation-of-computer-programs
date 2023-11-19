(load "exercise_2.78.scm")



(install-scheme-number-package)



(define x (make-scheme-number 3))
(define y (make-scheme-number 4))

(newline)
(display "x:     ")
(display x)
(newline)
(display "y:     ")
(display y)
(newline)
(display "x + y: ")
(display (add x y))
(newline)



;;; For comparision.

(define a (make-rational 1 2))
(define b (make-rational 1 3))

(newline)
(display "a:     ")
(display a)
(newline)
(display "b:     ")
(display b)
(newline)
(display "a + b: ")
(display (add a b))
(newline)
