(define (tree-map f tree)
  (if (list? tree)
      (map (lambda (t) (tree-map f t)) tree)
      (f tree)))
