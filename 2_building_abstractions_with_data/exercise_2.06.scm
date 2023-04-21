(define (zero f)
  (lambda (x) x))

(define (one f)
  (lambda (x) (f x)))

(define (two f)
  (lambda (x) (f (f x))))

(define (three f)
  (lambda (x) (f (f (f x)))))

(define (four f)
  (lambda (x) (f (f (f (f x))))))

(define (five f)
  (lambda (x) (f (f (f (f (f x)))))))



(define (add m n)
  (lambda (f) (lambda (x) ((m f) ((n f) x)))))

(define (mult m n)
  (lambda (f) (lambda (x) ((m (n f)) x))))

(define (expt m n)
  (lambda (f) (lambda (x) (((n m) f) x))))



(define (int-to-church n)
  (define (repeated f n)
    (if (= n 0)
        (lambda (x) x)
        (lambda (x) ((repeated f (- n 1)) (f x)))))
  (lamba (f) (repeated f n)))

(define (church-to-int n)
  (define (inc x) (+ x 1))
  ((n inc) 0))
