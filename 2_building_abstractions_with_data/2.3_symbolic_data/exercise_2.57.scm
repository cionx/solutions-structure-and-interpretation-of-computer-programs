(load "../../sicplib.scm")



;;; General purpose functions.

(define (operation? symbolic-op expr)
  (and (pair? expr) (eq? (car expr) symbolic-op)))

(define (terms expr)
  (cdr expr))

(define (combine symbolic-op number-op x y)
  (cond ((and (number? x) (number? y)) (number-op x y))
        ((and (operation? symbolic-op x)
              (operation? symbolic-op y))
         (cons symbolic-op (append (terms x) (terms y))))
        ((operation? symbolic-op x)
         (cons symbolic-op (append (terms x) (list y))))
        ((operation? symbolic-op y)
         (cons symbolic-op (cons x (terms y))))
        (else (list symbolic-op x y))))

(define (get-first combination)
  (cadr combination))

(define (singleton? x)
  (and (pair? x) (null? (cdr x))))

(define (format-operation symbolic-op terms)
  (if (singleton? terms)
      (car terms)
      (cons symbolic-op terms)))

(define (get-rest combination)
  (format-operation (car combination) (cddr combination)))



;;; Sums

(define (make-sum x y)
  (cond ((=number? x 0) y)
        ((=number? y 0) x)
        (else (combine '+ + x y))))

(define (sum? expr)
  (operation? '+ expr))

(define (addend sum)
  (get-first sum))

(define (augend sum)
  (get-rest sum))



;;; Products

(define (make-product x y)
  (cond ((or (=number? x 0) (=number? y 0)) 0)
        ((=number? x 1) y)
        ((=number? y 1) x)
        (else (combine '* * x y))))

(define (product? exp)
  (operation? '* exp))

(define (multiplier product)
  (get-first product))

(define (multiplicand product)
  (get-rest product))
