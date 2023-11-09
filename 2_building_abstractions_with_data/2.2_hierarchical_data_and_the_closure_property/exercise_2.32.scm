(define (subsets set)
  (if (null? set)
      (list '())
      (let ((x (car set))
            (not-containing-x (subsets (cdr set))))
        (append not-containing-x
                (map (lambda (subset) (cons x subset))
                     not-containing-x)))))
