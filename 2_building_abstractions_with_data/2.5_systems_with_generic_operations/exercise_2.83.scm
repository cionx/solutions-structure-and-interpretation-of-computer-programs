(load "../../sicplib.scm")



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



;;; Rationals (extension)

(define (install-rational-package)
  ;; internal procedures
  (define (numer x) (car x))
  (define (denom x) (cdr x))
  (define (make-rat n d)
    (let ((g (gcd n d)))
      (cons (/ n g) (/ d g))))
  (define (add-rat x y)
    (make-rat (+ (* (numer x) (denom y))
                 (* (numer y) (denom x)))
              (* (denom x) (denom y))))
  (define (sub-rat x y)
    (make-rat (- (* (numer x) (denom y))
                 (* (numer y) (denom x)))
              (* (denom x) (denom y))))
  (define (mul-rat x y)
    (make-rat (* (numer x) (numer y))
              (* (denom x) (denom y))))
  (define (div-rat x y)
    (make-rat (* (numer x) (denom y))
              (* (denom x) (numer y))))
  ;; interface to rest of the system
  (define (tag x) (attach-tag 'rational x))
  (put 'add
       '(rational rational)
       (lambda (x y) (tag (add-rat x y))))
  (put 'sub
       '(rational rational)
       (lambda (x y) (tag (sub-rat x y))))
  (put 'mul
       '(rational rational)
       (lambda (x y) (tag (mul-rat x y))))
  (put 'div
       '(rational rational)
       (lambda (x y) (tag (div-rat x y))))
  (put 'numer '(rational) numer)          ; added line
  (put 'denom '(rational) denom)          ; added line
  (put 'make
       'rational
       (lambda (n d) (tag (make-rat n d))))
  'done)

(define (numer x) (apply-generic 'numer x))
(define (denom x) (apply-generic 'denom x))



;;; Coercions

(define (install-coercions)
  ;; Procedures
  (define (scheme-number->rational n)
    (make-rational (contents n) 1))
  (define (integer->rational n)
    (scheme-number->rational (contents n)))
  (define (rational->real x)
    (make-real (/ (numer x) (denom x))))
  (define (scheme-number->complex x)
    (make-complex-from-real-imag (contents x) 0))
  (define (real->complex x)
    (scheme-number->complex (contents x)))
  ;; Installation
  (put-coercion 'integer 'rational integer->rational)
  (put-coercion 'rational 'real rational->real)
  (put-coercion 'real 'complex real->complex)
  (put 'raise
       '(integer)
       (lambda (n) (integer->rational (attach-tag 'integer n))))
  (put 'raise
       '(rational)
       (lambda (x) (rational->real (attach-tag 'rational x))))
  (put 'raise
       '(real)
       (lambda (x) (real->complex (attach-tag 'real x))))
  'done)

(define (raise x)
  (apply-generic 'raise x))
