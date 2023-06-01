(load "../../sicplib.scm")


(define (apply-generic op . args)
  (define (get-common-coercions arg-types target-type)
    (if (null? arg-types)
        '()
        (let ((head (car arg-types))
              (tail (cdr arg-types)))
          (let ((head->target-type
                  (if (eq? head target-type)
                      identity
                      (get-coercion head target-type)))
                (tail->target-type
                  (get-common-coercions tail target-type)))
            (if (and head->target-type tail->target-type)
                (cons head->target-type tail->target-type)
                #f)))))
  (define (iter target-types)
    (if (null? target-types)
        (error "No method for these types")
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
  (iter (map type-tag args)))

;; Both lists need to have the same length.
(define (zip-apply function-list value-list)
  (if (null? function-list)
      '()
      (cons ((car function-list) (car value-list))
            (zip-apply (cdr function-list) (cdr value-list)))))

;;; TESTING

(put-coercion 'test1 'test2 (lambda (x) (attach-tag 'test2 (contents x))))
(put-coercion 'test1 'test3 (lambda (x) (attach-tag 'test3 (contents x))))
(put-coercion 'test2 'test3 (lambda (x) (attach-tag 'test3 (contents x))))

(define (sum-3 x y z) (+ x y z))
(put 'sum '(test3 test3 test3) sum-3)

(define x (attach-tag 'test1 1))
(define y (attach-tag 'test2 2))
(define z (attach-tag 'test3 3))

(apply-generic 'sum x y z)
