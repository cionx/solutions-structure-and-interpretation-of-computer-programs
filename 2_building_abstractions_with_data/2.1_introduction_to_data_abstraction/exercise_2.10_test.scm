(load "exercise_2.10.scm")

(define (test-div a b c d)
  (div-interval (make-interval a b)
                (make-interval c d)))
