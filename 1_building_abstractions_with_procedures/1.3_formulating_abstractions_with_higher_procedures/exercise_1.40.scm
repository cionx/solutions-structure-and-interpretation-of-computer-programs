(load "../../sicplib.scm")

(define (cubic a b c)
  (lambda (x)
    (+ (cube x)
       (* a (square x))
       (* b x)
       c)))

(define (solve-cubic a b c)
  (newtons-method (cubic a b c) 1.))
