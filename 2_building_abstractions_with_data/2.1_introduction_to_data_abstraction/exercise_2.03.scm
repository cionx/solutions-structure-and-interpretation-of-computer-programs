; Points

(define (make-point x y) (cons x y))

(define (x-point p) (car p))

(define (y-point p) (cdr p))

; Rectangles, first representation

(define (make-rect corner width height)
  (cons corner
        (cons width height)))

(define (width rect)
  (car (cdr rect)))

(define (height rect)
  (cdr (cdr rect)))

; Rectangles, second representation

(define (make-rect p q)
  (cons p q))

(define (p-rect rect)
  (car rect))

(define (q-rect rect)
  (cdr rect))

(define (width rect)
  (let ((p (p-rect rect))
        (q (q-rect rect)))
    (abs (- (x-point p)
            (x-point q)))))

(define (height rect)
  (let ((p (p-rect rect))
        (q (q-rect rect)))
    (abs (- (y-point p)
            (y-point q)))))

; Perimeter and area, representation-independent

(define (perimeter rect)
  (+ (* 2 (height rect))
     (* 2 (width rect))))

(define (area rect)
  (* (height rect)
     (width rect)))
