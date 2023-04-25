(define (for-each f items)
  (unless (null? items)
    (f (car items))
    (for-each f (cdr items))))
