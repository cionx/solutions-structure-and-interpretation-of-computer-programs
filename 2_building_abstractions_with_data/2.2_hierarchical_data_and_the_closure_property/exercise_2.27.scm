;;; First solution

(define (deep-reverse items)
  (if (pair? items)
      (reverse (map deep-reverse items))
      items))



;;; Second solution

(define (deep-reverse items)
  (define (iter seq accum)
    (if (null? seq)
        accum
        (iter (cdr seq)
              (cons (deep-reverse (car seq))
                    accum))))
  (if (pair? items)
      (iter items '()) ; '() is the empty list
      items))
