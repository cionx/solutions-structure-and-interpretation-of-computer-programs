(define (entry tree) (car tree))

(define (left-branch tree) (cadr tree))

(define (right-branch tree) (caddr tree))

(define (make-tree entry left right)
  (list entry left right))



(define (element-of-oset? x set)
  (cond ((null? set) false)
        ((equal? x (car set)) true)
        (else (element-of-oset? x (cdr set)))))

(define (intersection-oset set1 set2)
  (cond ((or (null? set1) (null? set2)) '())
        ((element-of-oset? (car set1) set2)
         (cons (car set1)
               (intersection-oset (cdr set1) set2)))
        (else (intersection-oset (cdr set1) set2))))

(define (union-oset set1 set2)
  (cond ((null? set1) set2)
        ((null? set2) set1)
        (else (let ((x1 (car set1))
                    (x2 (car set2)))
                (cond ((< x1 x2)
                       (cons x1 (union-oset (cdr set1)
                                            set2)))
                      ((= x1 x2)
                       (cons x1 (union-oset (cdr set1)
                                            (cdr set2))))
                      (else
                       (cons x2 (union-oset set1
                                            (cdr set2)))))))))

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



(define (translate f)
  (lambda (x y)
    (oset->tree (f (tree->oset x) (tree->oset y)))))

(define intersection-set (translate intersection-oset))

(define union-set (translate union-oset))

;;; Testing

; (define t1 (oset->tree '(1 2 3 5 8 13 21 34 55 89)))
; (define t2 (oset->tree '(1 2 4 8 16 32 64)))
