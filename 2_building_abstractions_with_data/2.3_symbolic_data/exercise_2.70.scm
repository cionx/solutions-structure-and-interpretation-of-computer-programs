;;; Dependencies

(define (make-leaf symbol weight)
  (list 'leaf symbol weight))

(define (leaf? object) (eq? (car object) 'leaf))

(define (symbol-leaf x) (cadr x))

(define (weight-leaf x) (caddr x))

(define (make-code-tree left right)
  (list left
        right
        (append (symbols left) (symbols right))
        (+ (weight left) (weight right))))

(define (left-branch  tree) (car  tree))

(define (right-branch tree) (cadr tree))

(define (symbols tree)
  (if (leaf? tree)
      (list (symbol-leaf tree))
      (caddr tree)))

(define (weight tree)
  (if (leaf? tree)
      (weight-leaf tree)
      (cadddr tree)))

(define (adjoin-set x set)
  (cond ((null? set) (list x))
        ((< (weight x) (weight (car set))) (cons x set))
        (else (cons (car set)
                    (adjoin-set x (cdr set))))))

(define (make-leaf-set pairs)
  (if (null? pairs)
      '()
      (let ((pair (car pairs)))
        (adjoin-set (make-leaf (car pair)
                               (cadr pair))
                    (make-leaf-set (cdr pairs))))))

(define (generate-huffman-tree pairs)
  (successive-merge (make-leaf-set pairs)))

(define (successive-merge ordered-tree-list)
  (define (merge otl)
    (let ((t1 (car otl))
          (all-but-1 (cdr otl)))
      (if (null? all-but-1)
          t1
          (let ((t2 (car all-but-1))
                (all-but-2 (cdr all-but-1)))
            (merge
             (adjoin-set (make-code-tree t1 t2)
                         all-but-2))))))
  (if (null? ordered-tree-list)
      '()
      (merge ordered-tree-list)))

(define (encode message tree)
  (if (null? message)
      '()
      (append (encode-symbol (car message) tree)
              (encode (cdr message) tree))))

(define (encode-symbol sym tree)
  (define (encode-symbol-1 t)
    (cond ((null? t) (error "Cannot find symbol in an empty tree"))
          ((leaf? t)
           (if (eq? sym (symbol-leaf t)) '() false))
          (else (let ((left-result (encode-symbol-1 (left-branch t))))
                  (if (eq? left-result false)
                      (let ((right-result (encode-symbol-1 (right-branch t))))
                        (if (eq? right-result false)
                            false
                            (cons 1 right-result)))
                      (cons 0 left-result))))))
  (let ((result (encode-symbol-1 tree)))
    (if (eq? result false)
        (error "Cannot find symbol " sym)
        result)))



;;; Code

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
