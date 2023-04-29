(define (square-tree tree)
  (cond ((null? tree) (list))
        ((list? tree)
         (cons (square-tree (car tree))
               (square-tree (cdr tree))))
        (else (square tree))))

(define (square-tree tree)
  (if (list? tree)
      (map square-tree tree)
      (square tree)))

(define t
  (list 1
        (list 2 (list 3 4) 5)
        (list 6 7)))



(define (square x)
  (* x x))
