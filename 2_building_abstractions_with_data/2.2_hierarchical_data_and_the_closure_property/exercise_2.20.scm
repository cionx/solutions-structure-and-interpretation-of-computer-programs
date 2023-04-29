(define (same-parity x . items)
  (define (iter correct-parity? items)
    (if (null? items)
        (list) ; empty list
        (let ((head (car items))
              (tail (cdr items)))
          (let ((rest (iter correct-parity? tail)))
            (if (correct-parity? head)
                (cons head rest)
                rest)))))
  (cons x (iter (if (even? x)
                    even?
                    odd?)
                items)))
