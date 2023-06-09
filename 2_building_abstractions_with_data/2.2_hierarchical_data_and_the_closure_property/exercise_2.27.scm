(define (deep-reverse items)
  (if (list? items)
      (reverse (map deep-reverse items))
      items))

(define (deep-reverse items)
  (define (iter input acc)
    (if (null? input)
        acc
        (iter (cdr input)
              (cons (deep-reverse (car input))
                    acc))))
  (if (list? items)
      (iter items (list))
      items))
