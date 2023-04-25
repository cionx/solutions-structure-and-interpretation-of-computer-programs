; points

(define (make-point x y)
  (cons x y))

(define (x-point p)
  (car p))

(define (y-point p)
  (cdr p))

; lines

(define (make-segment p q)
  (cons p q))

(define (start-segment s)
  (car s))

(define (end-segment s)
  (cdr s))

; midpoint

(define (midpoint-segment s)
  (define (average x y)
    (/ (+ x y) 2))
  (let ((p1 (start-segment s))
        (p2 (end-segment s)))
    (let ((x1 (x-point p1))
          (x2 (x-point p2))
          (y1 (y-point p1))
          (y2 (y-point p2)))
      (make-point (average x1 x2) (average y1 y2)))))
