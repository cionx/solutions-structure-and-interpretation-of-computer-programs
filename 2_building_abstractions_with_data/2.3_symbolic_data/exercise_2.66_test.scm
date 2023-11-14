(load "exercise_2.66.scm")



;;; Records will be implemented as ordered pairs, with the respective key as
;;; the first entry.

(define (make-record key value) (cons key value))

(define (key record) (car record))



; To create trees:

(define (list->tree elements)
  (car (partial-tree elements (length elements))))

(define (partial-tree elts n)
  (if (= n 0)
      (cons '() elts)
      (let ((left-size (quotient (- n 1) 2)))
        (let ((left-result
               (partial-tree elts left-size)))
          (let ((left-tree (car left-result))
                (non-left-elts (cdr left-result))
                (right-size (- n (+ left-size 1))))
            (let ((this-entry (car non-left-elts))
                  (right-result
                   (partial-tree
                    (cdr non-left-elts)
                    right-size)))
              (let ((right-tree (car right-result))
                    (remaining-elts
                     (cdr right-result)))
                (cons (make-tree this-entry
                                 left-tree
                                 right-tree)
                      remaining-elts))))))))



; A test set of records:

(define t (list->tree (list (make-record 1 "a")
                            (make-record 2 "b")
                            (make-record 3 "c"))))
