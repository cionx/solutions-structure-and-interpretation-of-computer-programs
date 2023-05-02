(define (element-of-set? x set)
  (cond ((null? set) false)
        ((equal? x (car set)) true)
        (else (element-of-set? x (cdr set)))))

(define (union-set set1 set2)
  (if (null? set1)
      set2
      (let ((element (car set1))
            (smaller-union (union-set (cdr set1) set2)))
        (if (element-of-set? element set2)
            smaller-union
            (cons element smaller-union)))))
