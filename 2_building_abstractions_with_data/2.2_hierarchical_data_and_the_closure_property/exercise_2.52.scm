;;; The following code can be tested in DrRacket with the SICP Collections
;;; (https://docs.racket-lang.org/sicp-manual/index.html) installed.

#lang sicp
(#%require sicp-pict)



;;; A bunch of preliminary stuff

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

(define (identity x) x)

(define (right-split painter n)
  (if (= n 0)
      painter
      (let ((smaller (right-split painter (- n 1))))
        (beside painter (below smaller smaller)))))

(define (up-split painter n)
  (if (= n 0)
      painter
      (let ((smaller (up-split painter (- n 1))))
        (below painter
               (beside smaller smaller)))))

(define (corner-split painter n)
  (if (= n 0)
      painter
      (let ((up (up-split painter (- n 1)))
            (right (right-split painter (- n 1))))
        (let ((top-left (beside up up))
              (bottom-right (below right right))
              (corner (corner-split painter (- n 1))))
          (beside (below painter top-left)
                  (below bottom-right corner))))))

(define (square-of-four tl tr bl br)
  (lambda (painter)
    (let ((top (beside (tl painter) (tr painter)))
          (bottom (beside (bl painter) (br painter))))
      (below bottom top))))

(define (square-limit painter n)
  (let ((combine4 (square-of-four flip-horiz identity
                                  rotate180 flip-vert)))
    (combine4 (corner-split painter n))))



;;; First modification

(define new-wave
  (let ((top-left (make-path (list 0.00 0.85
                                   0.15 0.60
                                   0.30 0.65
                                   0.40 0.65
                                   0.35 0.85
                                   0.40 1.00)))
        (left-eye (make-path (list 0.40 0.85
                                   0.45 0.85)))
        (mouth (make-path (list 0.50 0.78
                                0.45 0.70
                                0.55 0.70
                                0.50 0.78)))
        (right-eye (make-path (list 0.55 0.85
                                    0.60 0.85)))
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
                               left-eye
                               mouth
                               right-eye
                               top-right
                               bottom-right
                               bottom-center
                               bottom-left))))

;;; Second modification

(define (new-corner-split painter n)
  (if (= n 0)
      (below (beside painter painter)
             (beside painter painter))
      (let ((up (up-split painter n))
            (right (right-split painter n)))
        (let ((top-left up)
              (bottom-right right)
              (corner (new-corner-split painter (- n 1))))
          (beside (below painter top-left)
                  (below bottom-right corner))))))

;;; Third modification

(define (new-square-limit painter n)
  (let ((combine4 (square-of-four rotate90 identity
                                  rotate180 rotate270)))
    (combine4 (corner-split painter n))))
