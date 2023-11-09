(load "exercise_2.38.scm") ; for fold-right and fold-left

(define (reverse sequence)
  (fold-right (lambda (x rest-reversed)
                (append rest-reversed (list x)))
              '()
              sequence))

(define (reverse sequence)
  (fold-left (lambda (previous-reversed x)
               (cons x previous-reversed))
             '()
             sequence))
