(load "exercise_2.83.scm") ; also loads sicplib

(define (get-level x)
  (let ((type (type-tag x)))
    (cond ((eq? type 'integer) 0)
          ((eq? type 'rational) 1)
          ((eq? type 'real) 2)
          ((eq? type 'complex) 3)
          (else #f))))


(define (raise-to-level x target-level)
  (define (iter y)
    (if (< (get-level y) target-level)
        (iter (raise y))
        y))
  (if target-level (iter x) #f))

(define (level-max . level-list)
  (define (binary-level-max level1 level2)
    (if (and level1 level2)
        (max level1 level2)
        #f))
  (define (iter acc levels)
    (if (null? levels)
        acc
        (iter (binary-level-max acc (car levels))
              (cdr levels))))
  (if (null? level-list)
      #f
      (iter (car level-list) (cdr level-list))))

(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (define (abort)
      (error "No method for these types"
             (list op type-tags)))
    (let ((proc (get op type-tags)))
      (if proc
          (apply proc (map contents args))
          (if (null? args)
              (abort)
              (let ((target-level
                      (apply level-max (map get-level args))))
                (let ((coerced-args
                        (map (lambda (x)
                               (raise-to-level x target-level))
                             args)))
                  (let ((coerced-type-tags
                          (map type-tag coerced-args)))
                    (let ((proc (get op coerced-type-tags)))
                      (if proc
                          (apply proc (map contents coerced-args))
                          (abort)))))))))))
