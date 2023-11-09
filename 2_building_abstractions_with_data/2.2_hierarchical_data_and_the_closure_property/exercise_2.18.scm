(define (reverse items)
  (define (iter seq rev-seq)
    (if (null? seq)
        rev-seq
        (let ((head (car seq))
              (tail (cdr seq)))
          (iter tail (cons head rev-seq)))))
  (iter items '())) ; '() is the empty list
