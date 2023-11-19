(load "../../sicplib.scm")



;;; The following implementation of integers and real numbers is taken from
;;; Exercise 2.83.

;;; Integers

(define (install-integer-package)
  (define (tag x) (attach-tag 'integer x))
  (put 'add '(integer integer) (lambda (x y) (tag (add x y))))
  (put 'sub '(integer integer) (lambda (x y) (tag (sub x y))))
  (put 'mul '(integer integer) (lambda (x y) (tag (mul x y))))
  (put 'div '(integer integer) (lambda (x y) (tag (div x y))))
  (put 'make 'integer (lambda (n) (if (integer? n)
                                      (tag (make-scheme-number n))
                                      (error "Not an integer" n))))
  'done)

(define (make-integer n)
  ((get 'make 'integer) n))

;;; Reals

(define (install-real-package)
  (define (tag x) (attach-tag 'real x))
  (put 'add '(real real) (lambda (x y) (tag (add x y))))
  (put 'sub '(real real) (lambda (x y) (tag (sub x y))))
  (put 'mul '(real real) (lambda (x y) (tag (mul x y))))
  (put 'div '(real real) (lambda (x y) (tag (div x y))))
  (put 'make 'real (lambda (x) (tag (make-scheme-number x))))
  'done)

(define (make-real x)
  ((get 'make 'real) x))



;;; Equality procedures

(define (equ? x y) (apply-generic 'equ? x y))

;; Equality of scheme-numbers, taken from Exercise 2.79
(put 'equ?
     '(scheme-number scheme-number)
     (lambda (x y) (= x y))) ; x and y are primitive numbers

;; Equality of integers
(put 'equ?
     '(integer integer)
     (lambda (x y) (equ? x y))) ; x and y are 'scheme-number

;; Equality of reals
(put 'equ?
     '(real real)
     (lambda (x y) (equ? x y))) ; x and y are 'scheme-number

;; Equality of complex numbers, taken from Exercise 2.79
(put 'equ?
     '(complex complex)
     (lambda (x y) (and (= (real-part x) (real-part y))
                        (= (imag-part x) (imag-part y)))))



;;; Raising procedure, similar to Exercise 2.83

(define (integer->scheme-number n)
  (contents n))

(define (real->scheme-number x)
  (contents x))

(define (scheme-number->primitive x)
  (contents x))

(define (integer->primitive n)
  (scheme-number->primitive (integer->scheme-number n)))

(define (real->primitive x)
  (scheme-number->primitive (real->scheme-number x)))

(define (raise x)
  (let ((type (type-tag x)))
    (cond ((eq? type 'integer)
           (make-real (integer->primitive x)))
          ((eq? type 'real)
           (make-complex-from-real-imag (real->primitive x) 0))
          (else (error "Cannot raise" x)))))

;;; Projection procedure

(define (project x)
  (let ((type (type-tag x)))
    (cond ((eq? type 'complex)
           (make-real (real-part x)))
          ((eq? type 'real)
           (make-integer (round (real->primitive x))))
          (else (error "Cannot project down" x)))))

;;; Drop procedure

(define (tagged-datum? datum)
  (and (pair? datum)
       (symbol? (car datum))))

(define (can-project? x)
  (and (tagged-datum? x)
       (let ((type (type-tag x)))
         (or (eq? type 'complex)
             (eq? type 'real)))))

(define (can-simplify? x)
  (and (can-project? x)
       (equ? x (raise (project x)))))

(define (drop x)
  (if (can-simplify? x)
      (drop (project x))
      x))



;;; Re-definition of apply-generic

(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (drop (apply proc (map contents args))) ; add drop support
          (error "No method for these types: APPLY-GENERIC"
                 (list op type-tags))))))
