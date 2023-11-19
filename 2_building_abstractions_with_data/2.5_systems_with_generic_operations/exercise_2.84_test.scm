(load "exercise_2.84.scm")



;;; Test code from 2.83
;;; We do not load exercise_2.83_test.scm because this would lead to a double
;;; loading of sicplib, which leads to problems. (It seems that the
;;; operation-table and coercion-table get reset.)

(install-rational-package)
(install-integer-package)
(install-real-package)
(install-coercions)

(define x1 (make-integer 5))
(define x2 ((get-coercion 'integer 'rational) x1))
(define x3 ((get-coercion 'rational 'real) x2))
(define x4 ((get-coercion 'real 'complex) x3))



;;; Test code for 2.84

(define (sum x y z)
  (add x (add y z)))

(sum x1 x2 x3)
(sum x2 x3 x4)
