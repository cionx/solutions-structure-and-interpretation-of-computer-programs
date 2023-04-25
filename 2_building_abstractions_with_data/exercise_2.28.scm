(define (frindge tree)
  (define (no-list? input)
    (not (list? input)))
  (cond ((no-list? tree) (list tree))
        ((null? tree) (list))
        (else (append (frindge (car tree))
                      (frindge (cdr tree))))))

(define (frindge tree)
  (define (no-list? input)
    (not (list? input)))
  (define (combine subtree right-frindge)
    (cond ((null? subtree) right-frindge)
          ((no-list? subtree) (cons subtree right-frindge))
          (else (combine (car subtree)
                         (combine (cdr subtree) right-frindge)))))
  (combine tree (list)))
