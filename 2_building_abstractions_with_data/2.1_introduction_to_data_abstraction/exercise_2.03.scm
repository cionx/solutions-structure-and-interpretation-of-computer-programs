; points

(define (make-point x y)
  (cons x y))

(define (x-point p)
  (car p))

(define (y-point p)
  (cdr p))

; rectangles, first representation

(define (make-rect point width height)
  (cons point
        (cons width height)))

(define (width r)
  (car (cdr r)))

(define (height r)
  (cdr (cdr r)))

; rectangles, second representation

(define (make-rect bl tr)
  (cons bl tr))

(define (bl-rect r)
  (car r))

(define (tr-rect r)
  (cdr r))

(define (width r)
  (let ((bl (bl-rect r))
        (tr (tr-rect r)))
    (- (x-point tr) (x-point bl))))

(define (height r)
  (let ((bl (bl-rect r))
        (tr (tr-rect r)))
    (- (y-point tr) (y-point bl))))

; perimeter and area, representation-independent

(define (perimeter r)
  (+ (* 2 (height r))
     (* 2 (width r))))

(define (area r)
  (* (height r)
     (width r)))
