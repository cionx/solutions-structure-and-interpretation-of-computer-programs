(load "exercise_2.02.scm")

(define p (make-point 1 2))
(define q (make-point 7 8))
(define seg (make-segment p q))

(print-point (midpoint-segment seg))
;; The result should be (4, 5).
