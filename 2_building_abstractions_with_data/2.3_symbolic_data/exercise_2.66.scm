;;; Operations for binary trees. We don’t use sicplib, because some of these
;;; procedures are later overwritten.

(define (entry tree) (car tree))

(define (left-branch tree) (cadr tree))

(define (right-branch tree) (caddr tree))

(define (make-tree entry left right)
  (list entry left right))

;;; Code

(define (lookup given-key set-of-records)
  (if (null? set-of-records)
      #f
      (let ((test-record (entry set-of-records)))
        (let ((test-key (key test-record)))
          (cond ((= given-key test-key) test-record)
                ((< given-key test-key)
                 (lookup given-key
                         (left-branch set-of-records)))
                ((> given-key test-key)
                 (lookup given-key
                         (right-branch set-of-records))))))))
