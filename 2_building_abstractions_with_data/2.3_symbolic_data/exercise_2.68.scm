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

;;; Code

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

(define sample-tree
  (make-code-tree (make-leaf 'A 4)
                  (make-code-tree
                   (make-leaf 'B 2)
                   (make-code-tree
                    (make-leaf 'D 1)
                    (make-leaf 'C 1)))))

(define sample-message '(0 1 1 0 0 1 0 1 0 1 1 1 0))

(encode '(A D A B B C A) sample-tree)
