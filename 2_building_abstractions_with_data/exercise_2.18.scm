(define (reverse items)
  (define (iter input acc)
    (if (null? input)
        acc
        (let ((head (car input))
              (tail (cdr input)))
          (iter tail (cons head acc)))))
  (iter items (list )))
