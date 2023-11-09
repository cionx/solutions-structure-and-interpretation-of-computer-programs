;;; Exercise 2.46

(define (make-vect x y)
  (list x y))

(define (xcor-vect v)
  (car v))

(define (ycor-vect v)
  (cadr v))

(define (add-vect v w)
  (make-vect (+ (xcor-vect v)
                (xcor-vect w))
             (+ (ycor-vect v)
                (ycor-vect w))))

(define (sub-vect v w)
  (make-vect (- (xcor-vect v)
                (xcor-vect w))
             (- (ycor-vect v)
                (ycor-vect w))))

(define (scale-vect scalar v)
  (make-vect (* scalar (xcor-vect v))
             (* scalar (ycor-vect v))))



;;; Exercise 2.48

(define (make-segment start end)
  (list start end))

(define (start-segment segment)
  (car segment))

(define (end-segment segment)
  (cadr segment))

(define (segments->painter segment-list)
  (lambda (frame)
    (for-each
      (lambda (segment)
        (draw-line
         ((frame-coord-map frame)
          (start-segment segment))
         ((frame-coord-map frame)
          (end-segment segment))))
      segment-list)))



;;; The following code can be tested in DrRacket with the SICP Collections
;;; (https://docs.racket-lang.org/sicp-manual/index.html) installed.
;;; It will use an internal version of segments->painter instead of the above
;;; one, so don’t copy the above code!

#lang sicp
(#%require sicp-pict)

(define (make-path coords)
  (define (coords->vects coords)
    (if (null? coords)
        '()
        (cons (make-vect (car coords)
                         (cadr coords))
              (coords->vects (cddr coords)))))
  (define (vects->path vects)
    (if (null? (cdr vects))
        '()
        (cons (make-segment (car vects)
                            (cadr vects))
              (vects->path (cdr vects)))))
  (vects->path (coords->vects coords)))

(define outline
  (segments->painter (make-path (list 0 0
                                      0 1
                                      1 1
                                      1 0
                                      0 0))))

(define full-x
  (segments->painter (append (make-path (list 0 0
                                              1 1))
                             (make-path (list 0 1
                                              1 0)))))

(define diamond
  (segments->painter (make-path (list 0.5 0.0
                                      1.0 0.5
                                      0.5 1.0
                                      0.0 0.5
                                      0.5 0.0))))

(define wave
  (let ((top-left (make-path (list 0.00 0.85
                                   0.15 0.60
                                   0.30 0.65
                                   0.40 0.65
                                   0.35 0.85
                                   0.40 1.00)))
        (top-right (make-path (list 0.60 1.00
                                    0.65 0.85
                                    0.60 0.65
                                    0.75 0.65
                                    1.00 0.35)))
        (bottom-right (make-path (list 1.00 0.15
                                       0.60 0.45
                                       0.75 0.00)))
        (bottom-center (make-path (list 0.60 0.00
                                        0.50 0.30
                                        0.40 0.00)))
        (bottom-left (make-path (list 0.25 0.00
                                      0.35 0.50
                                      0.30 0.60
                                      0.15 0.40
                                      0.00 0.65))))
    (segments->painter (append top-left
                               top-right
                               bottom-right
                               bottom-center
                               bottom-left))))

;;; Testing the procedures

(display "outline")
(newline)
(paint outline)

(display "full-x")
(newline)
(paint full-x)

(display "diamond")
(newline)
(paint diamond)

(display "wave")
(newline)
(paint wave)
