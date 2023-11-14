;;; operations for binary trees
;;; We don’t use sicplib, because some of these procedures are later
;;; overwritten

(define (entry tree) (car tree))

(define (left-branch tree) (cadr tree))

(define (right-branch tree) (caddr tree))

(define (make-tree entry left right)
  (list entry left right))



;;; operations for sets as ordered lists

(define (intersection-oset set1 set2)
  (if (or (null? set1) (null? set2))
      '()
      (let ((x1 (car set1))
            (x2 (car set2))
            (rest1 (cdr set1))
            (rest2 (cdr set2)))
        (cond ((= x1 x2)
               (cons x1 (intersection-oset rest1 rest2)))
              ((< x1 x2)
               (intersection-oset rest1 set2))
              ((> x1 x2)
               (intersection-oset set1 rest2))))))

(define (union-oset set1 set2)
  (cond ((null? set1) set2)
        ((null? set2) set1)
        (else
         (let ((x1 (car set1))
               (x2 (car set2))
               (rest1 (cdr set1))
               (rest2 (cdr set2)))
           (cond ((= x1 x2)
                  (cons x1 (union-oset rest1 rest2)))
                 ((< x1 x2)
                  (cons x1 (union-oset rest1 set2)))
                 ((> x1 x2)
                  (cons x2 (union-oset set1 rest2))))))))



;;; tree -> ordered list

(define (tree->oset tree)
  (define (copy-to-list tree result-list)
    (if (null? tree)
        result-list
        (copy-to-list (left-branch tree)
                      (cons (entry tree)
                            (copy-to-list
                             (right-branch tree)
                             result-list)))))
  (copy-to-list tree '()))



;;; ordered list -> balanced binary search tree

(define (oset->tree elements)
  (car (partial-tree elements (length elements))))

(define (partial-tree elts n)
  (if (= n 0)
      (cons '() elts)
      (let ((left-size (quotient (- n 1) 2)))
        (let ((left-result
               (partial-tree elts left-size)))
          (let ((left-tree (car left-result))
                (non-left-elts (cdr left-result))
                (right-size (- n (+ left-size 1))))
            (let ((this-entry (car non-left-elts))
                  (right-result
                   (partial-tree
                    (cdr non-left-elts)
                    right-size)))
              (let ((right-tree (car right-result))
                    (remaining-elts
                     (cdr right-result)))
                (cons (make-tree this-entry
                                 left-tree
                                 right-tree)
                      remaining-elts))))))))



;;; translating back and forth

(define (translate f)
  (lambda (x y)
    (oset->tree (f (tree->oset x) (tree->oset y)))))

(define intersection-set (translate intersection-oset))

(define union-set (translate union-oset))
