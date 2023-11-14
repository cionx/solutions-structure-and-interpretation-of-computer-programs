(load "../../sicplib.scm")

(define (generate-huffman-tree pairs)
  (successive-merge (make-leaf-set pairs)))

(define (successive-merge ordered-tree-list)
  (define (merge ordered-tree-list)
    (let ((t1 (car ordered-tree-list))
          (all-but-1 (cdr ordered-tree-list)))
      (if (null? all-but-1)
          t1
          (let ((t2 (car all-but-1))
                (all-but-2 (cdr all-but-1)))
            (merge (adjoin-set (make-code-tree t1 t2)
                               all-but-2))))))
  (if (null? ordered-tree-list)
      '()
      (merge ordered-tree-list)))
