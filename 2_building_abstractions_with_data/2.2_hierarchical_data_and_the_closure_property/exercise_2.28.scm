(define (fringe tree)
  (cond ((null? tree) '()) ; '() is the empty list
        ((not (pair? tree)) (list tree)) ; leaf case
        (else (append (fringe (car tree))
                      (fringe (cdr tree))))))

(define (fringe tree)
  (define (extend-fringe subtree right-fringe)
    (cond ((null? subtree) right-fringe)
          ((not (pair? subtree)) (cons subtree right-fringe))
          (else (extend-fringe (car subtree)
                               (extend-fringe (cdr subtree) right-fringe)))))
  (extend-fringe tree '())) ; '() is the empty list
