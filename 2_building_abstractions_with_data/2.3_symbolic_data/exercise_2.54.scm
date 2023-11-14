(define (equal? a b)
  (or
    ; two symbols that are eq?
    (and (symbol? a) (symbol? b) (eq? a b))
    ; two empty lists
    (and (null? a) (null? b))
    ; two nonempty lists/pairs
    (and (pair? a)
         (pair? b)
         (not (null? a))
         (not (null? b))
         (equal? (car a) (car b))
         (equal? (cdr a) (cdr b)))))
