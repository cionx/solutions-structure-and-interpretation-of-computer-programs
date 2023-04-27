(define (reverse sequence)
  (fold-right (lambda (x rest) (append rest (list x))) '() sequence))

(define (reverse sequence)
  (fold-left (lambda (previous x) (cons x previous)) '() sequence))
