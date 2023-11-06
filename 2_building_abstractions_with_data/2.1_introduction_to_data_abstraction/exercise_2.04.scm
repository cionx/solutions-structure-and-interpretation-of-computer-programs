;;; From the book.

(define  (cons x y)
  (lambda (m) (m x y)))

(define (car z)
  (z (lambda (p q) p)))



;;; New code.

(define (cdr z)
  (z (lambda (p q) q)))
