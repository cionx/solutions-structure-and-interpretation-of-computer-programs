(load "../../sicplib.scm") ; for dx

(define (smooth f)
  (lambda (x)
    (/ (+ (f (- x dx))
          (f x)
          (f (+ x dx)))
       3)))

(define (repeated-smooth f n)
  ((repeated smooth n) f))
