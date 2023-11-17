(load "../../sicplib.scm")



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
