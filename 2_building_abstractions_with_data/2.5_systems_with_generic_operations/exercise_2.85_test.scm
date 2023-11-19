(load "exercise_2.85.scm")

(install-integer-package)
(install-real-package)
(install-complex-package)



;;; Testing raise and project

(define x1 (make-integer 5))
(define x2 (raise x1))
(define x3 (raise x2))
(define x4 (project x3))
(define x5 (project x4))



;;; Testing drop

(equ? (drop x3) x1)



;;; Testing the overall system

(define y1 (make-complex-from-real-imag 2 3))
(define y2 (make-complex-from-real-imag 4 -3))
(define y3 (add y1 y2))
