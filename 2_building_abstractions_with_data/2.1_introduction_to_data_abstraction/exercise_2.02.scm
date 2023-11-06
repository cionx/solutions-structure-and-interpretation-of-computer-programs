;;; Points

(define (make-point x y) (cons x y))

(define (x-point p) (car p))

(define (y-point p) (cdr p))

(define (print-point p)
  (newline)
  (display "(")
  (display (x-point p))
  (display ", ")
  (display (y-point p))
  (display ")"))

;;; Lines

(define (make-segment p q)
  (cons p q))

(define (start-segment s)
  (car s))

(define (end-segment s)
  (cdr s))

;;; Midpoint

(define (midpoint-segment s)
  (define (average x y)
    (/ (+ x y) 2))
  (let ((p-start (start-segment s))
        (p-end (end-segment s)))
    (let ((x-start (x-point p-start))
          (x-end (x-point p-end))
          (y-start (y-point p-start))
          (y-end (y-point p-end)))
      (make-point (average x-start x-end)
                  (average y-start y-end)))))
