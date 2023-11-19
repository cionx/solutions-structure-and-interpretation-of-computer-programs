(load "exercise_2.79.scm")



(define z1 (make-complex-from-real-imag 1 2))
(define z2 (make-complex-from-real-imag 1 2))
(define z3 (make-complex-from-real-imag 1 3))

(newline)
(display "z1: ")
(display z1)
(newline)
(display "z2: ")
(display z2)
(newline)
(display "z3: ")
(display z3)
(newline)
(display "equ? z1 z2: ")
(display (equ? z1 z2))
(newline)
(display "equ? z1 z3: ")
(display (equ? z1 z3))
(newline)
