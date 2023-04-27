(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (flatmap proc seq)
  (accumulate append '() (map proc seq)))

(define (enumerate-interval low high)
  (if (> low high)
      '()
      (cons low (enumerate-interval (+ low 1) high))))




(define (sum-triples n s)
  (define (make-triple i j k)
    (list i j k))
  (define (make-all-triples n)
    (let ((numbers (enumerate-interval 1 n)))
      (flatmap (lambda (i)
                 (flatmap (lambda (j)
                            (map (lambda (k)
                                   (make-triple i j k))
                                 numbers))
                          numbers))
               numbers)))
  (define (correct-sum? triple)
    (= (+ (car triple)
          (cadr triple)
          (caddr triple))
       s))
  (filter correct-sum? (make-all-triples n)))
