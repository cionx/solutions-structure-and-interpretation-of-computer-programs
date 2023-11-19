(load "exercise_2.83.scm")



(install-rational-package)
(install-integer-package)
(install-real-package)
(install-coercions)

(define x1 (make-integer 5))
(define x2 ((get-coercion 'integer 'rational) x1))
(define x3 ((get-coercion 'rational 'real) x2))
(define x4 ((get-coercion 'real 'complex) x3))
