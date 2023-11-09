(load "../../sicplib.scm") ; for `accumulate`



(define (map f sequence)
  (accumulate (lambda (x items) (cons (f x) items))
              '()
              sequence))

(define (append seq1 seq2)
  (accumulate cons seq2 seq1))

(define (length sequence)
  (accumulate (lambda (x y) (+ y 1)) 0 sequence))
