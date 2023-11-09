(load "../../sicplib.scm") ; for `flatmap`, `filter`, `enumerate-interval`

(define (make-all-triples n)
  (let ((numbers (enumerate-interval 1 n)))
    (flatmap (lambda (i)
               (flatmap (lambda (j)
                          (map (lambda (k)
                                 (list i j k))
                               numbers))
                        numbers))
             numbers)))

(define (sum-triples n s)
  (define (distinct? triple)
    (let ((i (car triple))
          (j (cadr triple))
          (k (caddr triple)))
      (not (or (= i j) (= i k) (= j k)))))
  (define (correct-sum? triple)
    (= (+ (car triple)
          (cadr triple)
          (caddr triple))
       s))
  (filter correct-sum?
          (filter distinct?
                  (make-all-triples n))))
