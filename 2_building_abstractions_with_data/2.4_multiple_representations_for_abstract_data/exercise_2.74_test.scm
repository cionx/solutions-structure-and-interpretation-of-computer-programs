(load "exercise_2.74.scm")



;;; Internal procedures of the first division.

(define (make-attribute-1 name value)
  (cons name value))

(define (name-attribute-1 attr)
  (car attr))

(define (value-attribute-1 attr)
  (cdr attr))

(define (make-record-1 name . attr-list)
  (cons name attr-list))

(define (name-record-1 rec)
  (car rec))

(define (attributes-record-1 rec)
  (cdr rec))

(define (make-new-file-1) '())

(define (insert-records-1 file . rec-list)
  (append rec-list file))

(define (get-record-1 file name)
  (if (null? file)
      #f
      (let ((head (car file)))
        (if (eq? (name-record-1 head) name)
            head
            (get-record-1 (cdr file) name)))))

(define (set-attributes-1 rec . attr-list)
  (make-record-1 (name-record-1 rec)
                 (append attr-list
                         (attributes-record-1 rec))))

(define (get-value-1 rec attr-name)
  (define (iter attr-list)
    (if (null? attr-list)
        #f
        (let ((head (car attr-list)))
          (if (eq? attr-name (name-attribute-1 head))
              (value-attribute-1 head)
              (iter (cdr attr-list))))))
  (iter (attributes-record-1 rec)))

(define test-file-1
  (insert-records-1
   (make-new-file-1)
   (make-record-1 'John
                  (make-attribute-1 'age 35)
                  (make-attribute-1 'salary 63520.00))
   (make-record-1 'Mary
                  (make-attribute-1 'age 29)
                  (make-attribute-1 'salary 58639.50))))



;;; Internal procedures of the second division.
;;; Their IT departement is a bit lazy and just
;;; copied the work of the first department.

(define make-attribute-2 make-attribute-1)
(define name-attribute-2 name-attribute-1)
(define value-attribute-2 name-attribute-1)
(define make-record-2 make-record-1)
(define name-record-2 name-record-1)
(define attributes-record-2 attributes-record-1)
(define make-new-file-2 make-new-file-1)
(define insert-records-2 insert-records-1)
(define get-record-2 get-record-1)
(define set-attributes-2 set-attributes-1)
(define get-value-2 get-value-1)

(define test-file-2
  (insert-records-2
   (make-new-file-2)
   (set-attributes-2 (make-record-2
                      'Bob
                      (make-attribute-2 'age 40)
                      (make-attribute-2 'salary 65432.10)))
   (set-attributes-2 (make-record-2
                      'Clarice
                      (make-attribute-2 'age 42)
                      (make-attribute-2 'salary 66666.66)))))



;;; Both divisions register their procedures for global usage.

(put 'file 'first-division (tag-division-file 'first-division test-file-1))
(put 'get-record 'first-division get-record-1)
(put 'record-failure 'first-division #f)
(put 'get-value 'first-division get-value-1)
(put 'value-failure 'first-division #f)

(put 'file 'second-division (tag-division-file 'second-division test-file-2))
(put 'get-record 'second-division get-record-2)
(put 'record-failure 'second-division #f)
(put 'get-value 'second-division get-value-2)
(put 'value-failure 'second-division #f)



;;; tagged file lists

(define tagged-file-1 (get 'file 'first-division))
(define tagged-file-2 (get 'file 'second-division))

(define files (list tagged-file-1 tagged-file-2))
