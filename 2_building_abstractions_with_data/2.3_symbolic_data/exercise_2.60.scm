(define (filter predicate sequence)
  (cond ((null? sequence) '())
        ((predicate (car sequence))
         (cons (car sequence)
               (filter predicate (cdr sequence))))
        (else (filter predicate (cdr sequence)))))



(define (element-of-set? x set)
  (and (not (null? set))
       (or (equal? x (car set))
           (element-of-set? x (cdr set)))))

(define (adjoin-set x set)
  (cons x set))

(define (intersection-set set1 set2)
  (filter (lambda (x) (element-of-set? x set1)) set2))

(define (union-set set1 set2)
  (append set1 set2))
