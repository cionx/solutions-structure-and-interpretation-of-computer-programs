(load "exercise_1.42.scm") ; for compose
(load "../../sicplib.scm") ; for square and identity

(define (repeated f n)
  (if (= n 0)
      identity
      (compose f (repeated f (- n 1)))))

((repeated square 2) 5)
