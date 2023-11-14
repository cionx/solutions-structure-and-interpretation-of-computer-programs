(load "exercise_2.69.scm")



(define pairs '((A 4) (B 2) (C 1) (D 1)))

(define sample-tree
  (make-code-tree (make-leaf 'A 4)
                  (make-code-tree
                   (make-leaf 'B 2)
                   (make-code-tree
                    (make-leaf 'D 1)
                    (make-leaf 'C 1)))))

(newline)
(display "Sample tree")
(newline)
(display sample-tree)

(newline)
(display "Computed tree")
(newline)
(display (generate-huffman-tree pairs))
