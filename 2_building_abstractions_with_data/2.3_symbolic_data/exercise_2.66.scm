;;; Dependencies

(define (entry tree) (car tree))

(define (left-branch tree) (cadr tree))

(define (right-branch tree) (caddr tree))

(define (make-tree entry left right)
  (list entry left right))

;;; Code

(define (lookup given-key set-of-records)
  (if (null? set-of-records)
      false
      (let ((test-record (entry set-of-records)))
        (let ((test-key (key test-record)))
          (cond ((= given-key test-key) test-record)
                ((< given-key test-key)
                 (lookup given-key
                         (left-branch set-of-records)))
                ((> given-key test-key)
                 (lookup given-key
                         (right-branch set-of-records))))))))

;;; For testing

(define (make-record key value) (cons key value))

(define (key record) (car record))

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

(define t (list->tree (list (make-record 1 "a")
                            (make-record 2 "b")
                            (make-record 3 "c"))))
