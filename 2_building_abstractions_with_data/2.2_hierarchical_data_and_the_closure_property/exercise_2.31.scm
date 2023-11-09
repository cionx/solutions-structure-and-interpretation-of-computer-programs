(define (tree-map f tree)
  (cond ((null? tree) '()) ; '() is the empty list
        ((not (pair? tree)) (f tree)) ; leaf case
        (else (cons (tree-map f (car tree))
                    (tree-map f (cdr tree))))))

(define (tree-map f tree)
  (map (lambda (sub-tree)
         (if (pair? sub-tree)
             (tree-map f sub-tree)
             (f sub-tree)))
       tree))
