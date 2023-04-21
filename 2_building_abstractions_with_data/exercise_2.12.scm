(define (make-center-percent c percent)
  (let ((w (* (/ percent 100)
              (abs c))))
    (make-center-width c w)))

(define (center i)
  (define (average x y) (/ (+ x y) 2))
  (average (lower-bound i) (upper-bound i)))

(define (width i)
  (/ (- (upper-bound i) (lower-bound i)) 2))

(define (percentage i)
  (let ((c (abs (center i))))
    (if (= c 0)
        (error "Division by zero in percentage.")
        (/ (width i) c))))
