(load "../../sicplib.scm")

(define (encode message tree)
  (if (null? message)
      '()
      (append (encode-symbol (car message) tree)
              (encode (cdr message) tree))))

(define (encode-symbol sym tree)
  (define (encode-symbol-1 current-branch)
    (cond ((null? current-branch)
           (error "Cannot find symbol in an empty tree"))
          ((leaf? current-branch)
           (if (eq? sym (symbol-leaf current-branch))
               '()
               #f))
          (else
           (let ((left-result
                  (encode-symbol-1 (left-branch current-branch))))
            (if (not left-result)
                (let ((right-result
                       (encode-symbol-1 (right-branch current-branch))))
                  (if (not right-result)
                      #f
                      (cons 1 right-result)))
                (cons 0 left-result))))))
  (let ((result (encode-symbol-1 tree)))
    (if (eq? result #f)
        (error "Cannot find symbol in tree" sym)
        result)))



(define sample-tree
  (make-code-tree (make-leaf 'A 4)
                  (make-code-tree
                   (make-leaf 'B 2)
                   (make-code-tree
                    (make-leaf 'D 1)
                    (make-leaf 'C 1)))))

(define sample-message '(0 1 1 0 0 1 0 1 0 1 1 1 0))

(encode '(A D A B B C A) sample-tree)
