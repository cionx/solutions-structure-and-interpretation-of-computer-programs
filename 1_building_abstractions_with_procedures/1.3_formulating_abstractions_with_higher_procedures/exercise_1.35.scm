(load "../../sicplib.scm")

(fixed-point (lambda (x) (+ 1 (/ 1 x))) 1.)
