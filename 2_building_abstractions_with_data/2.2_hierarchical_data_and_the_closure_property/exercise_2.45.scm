;;; This code can be tested in DrRacket with the SICP Collections
;;; (https://docs.racket-lang.org/sicp-manual/index.html) installed.

#lang sicp
(#%require sicp-pict)



(define (split first second)
  (define (transformation painter n)
    (if (= n 0)
        painter
        (let ((smaller (transformation painter (- n 1))))
          (first painter (second smaller smaller)))))
  transformation)



;;; Testing

(define right-split (split beside below))
(define up-split (split below beside))

(display "right-split 2")
(newline)
(paint (right-split einstein 2))

(display "up-split 2")
(newline)
(paint (up-split einstein 2))
