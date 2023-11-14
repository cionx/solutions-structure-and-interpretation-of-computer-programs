(load "exercise_2.68.scm")
(load "exercise_2.69.scm")



(define pairs '((A 2) (BOOM 1) (GET 2) (JOB 2) (NA 16) (SHA 3) (YIP 9) (WAH 1) (SPACE 30) (LINEBREAK 5)))

(define tree (generate-huffman-tree pairs))

(define message '(Get a job
                  Sha na na na na na na na na
                  Get a job
                  Sha na na na na na na na na
                  Wah yip yip yip yip yip yip yip yip yip
                  Sha boom))

(define encoded-message (encode message tree))



(newline)
(display "Tree:")
(newline)
(display tree)
(newline)
(display "Message:")
(newline)
(display message)
(newline)
(display "Encoded message:")
(newline)
(display encoded-message)
(newline)
(display "Number of bits:")
(newline)
(display (length encoded-message))
