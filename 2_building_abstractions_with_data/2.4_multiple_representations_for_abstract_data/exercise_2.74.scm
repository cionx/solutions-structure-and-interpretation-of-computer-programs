;;; Dependencies

(define (assoc key records)
  (cond ((null? records) false)
        ((equal? key (caar records)) (car records))
        (else (assoc key (cdr records)))))

(define (make-table)
  (let ((local-table (list '*table*)))
    (define (lookup key-1 key-2)
      (let ((subtable
             (assoc key-1 (cdr local-table))))
        (if subtable
            (let ((record
                   (assoc key-2 (cdr subtable))))
              (if record (cdr record) false))
            false)))
    (define (insert! key-1 key-2 value)
      (let ((subtable
             (assoc key-1 (cdr local-table))))
        (if subtable
            (let ((record
                   (assoc key-2 (cdr subtable))))
              (if record
                  (set-cdr! record value)
                  (set-cdr! subtable
                            (cons (cons key-2 value)
                                  (cdr subtable)))))
            (set-cdr! local-table
                      (cons (list key-1 (cons key-2 value))
                            (cdr local-table)))))
      'ok)
    (define (dispatch m)
      (cond ((eq? m 'lookup-proc) lookup)
            ((eq? m 'insert-proc!) insert!)
            (else (error "Unknown operation: TABLE" m))))
    dispatch))

(define operation-table (make-table))
(define get (operation-table 'lookup-proc))
(define put (operation-table 'insert-proc!))

(define (attach-tag type-tag contents)
  (cons type-tag contents))

(define (type-tag datum)
  (if (pair? datum)
      (car datum)
      (error "Bad tagged datum: TYPE-TAG" datum)))

(define (contents datum)
  (if (pair? datum)
      (cdr datum)
      (error "Bad tagged datum: CONTENTS" datum)))



;;; Code

;;; Code in each division:
;;;
;;; (division-get-record division-file ⟨name⟩)
;;; return on failure: ⟨division-record-failure⟩
;;;
;;; (divison-get-value ⟨record⟩ ⟨value⟩)
;;; return on failure: ⟨division-value-failure⟩

(define (tag-division-file division-name division-file)
  (attach-tag division-name
              (map (lambda (rec) (attach-tag division-name rec))
                   division-file)))

;;; Registration of procedures for global usage.
;;;
;;; (put 'file division-name tagged-division-file)
;;;
;;; (put 'get-record division-name division-get-record)
;;; (put 'record-failure division-name division-record-failure)
;;;
;;; (put 'get-value division-name division-get-value)
;;; (put 'value-failure division-name division-value-failure)

(define (get-record file name)
  (let ((division (type-tag file)))
    (let ((result ((get 'get-record division)
                   (map contents (contents file))
                   name)))
      (if (eq? result (get 'record-failure division))
          #f
          (attach-tag division result)))))

(define (get-value rec attr)
  (let ((division (type-tag rec)))
    (let ((result ((get 'get-value division)
                   (contents rec)
                   attr)))
      (if (eq? result (get 'value-failure division))
          #f
          result))))

(define (find-record file-list name)
  (define (iter fs)
    (if (null? fs)
        #f
        (let ((result (get-record (car fs) name)))
          (if (eq? result #f)
              (iter (cdr fs))
              result))))
  (iter file-list))



;;; For testing

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

(put 'file 'first-division (tagged-division-file
                            'first-division
                            test-file-1))
(put 'get-record 'first-division get-record-1)
(put 'record-failure 'first-division #f)
(put 'get-value 'first-division get-value-1)
(put 'value-failure 'first-division #f)

(put 'file 'second-division (tagged-division-file
                            'second-division
                            test-file-2))
(put 'get-record 'second-division get-record-2)
(put 'record-failure 'second-division #f)
(put 'get-value 'second-division get-value-2)
(put 'value-failure 'second-division #f)

;;; tagged file lists

(define tagged-file-1 (get 'file 'first-division))
(define tagged-file-2 (get 'file 'second-division))

(define files (list tagged-file-1 tagged-file-2))
