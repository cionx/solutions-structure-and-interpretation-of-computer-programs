(load "exercise_1.22.scm") ;; also loads sicplib


;;; Code given by the exercise, with the modification
;;; to start-prime-test that the exercise asks for.

(define (start-prime-test n start-time)
  (if (fast-prime? n 1000000)
      (report-prime (- (runtime) start-time))))
