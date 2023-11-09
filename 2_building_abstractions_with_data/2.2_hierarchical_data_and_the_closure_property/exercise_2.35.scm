(load "../../sicplib.scm") ; for `accumulate`


(define (count-leaves tree)
  (define (leaf-number sub-tree)
    (if (pair? sub-tree)
        (count-leaves sub-tree)
        1))
  (accumulate + 0 (map leaf-number tree)))
