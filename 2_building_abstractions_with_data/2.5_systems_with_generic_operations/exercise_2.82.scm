(load "../../sicplib.scm")

(define (get-common-coercions input-types target)
  (if (null? input-types)
      '()
      (let ((head (car input-types))
            (tail (cdr input-types)))
        (let ((head->target
                (if (eq? head target)
                    identity
                    (get-coercion head target)))
              (tail->target
                (get-common-coercions tail target)))
          (if (and head->target tail->target)
              (cons head->target tail->target)
              #f)))))

;; Both lists need to have the same length.
(define (zip-apply procs args)
  (if (null? procs)
      '()
      (cons ((car procs) (car args))
            (zip-apply (cdr procs) (cdr args)))))

(define (apply-generic op . args)
  (define (iter target-types)
    (if (null? target-types)
        (error "No procedure for these types")
        (let ((target-type (car target-types))
              (other-types (cdr target-types))
              (arg-types (map type-tag args)))
          (let ((coercions (get-common-coercions arg-types target-type)))
            (if coercions
                (let ((coerced-args (zip-apply coercions args)))
                  (let ((coerced-types (map type-tag coerced-args)))
                    (let ((proc (get op coerced-types)))
                      (if proc
                          (apply proc (map contents coerced-args))
                          (iter other-types)))))
                (iter other-types))))))
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (apply proc (map contents args))
          (iter type-tags)))))
