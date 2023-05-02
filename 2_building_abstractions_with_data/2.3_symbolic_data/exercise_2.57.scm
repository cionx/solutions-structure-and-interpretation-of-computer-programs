(define (=number? exp num)
  (and (number? exp) (= exp num)))

(define (variable? x) (symbol? x))
(define (same-variable? v1 v2)
  (and (variable? v1) (variable? v2) (eq? v1 v2)))

(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp)
         (if (same-variable? exp var) 1 0))
        ((sum? exp)
         (make-sum (deriv (addend exp) var)
                   (deriv (augend exp) var)))
        ((product? exp)
         (make-sum
          (make-product (multiplier exp)
                        (deriv (multiplicand exp) var))
          (make-product (deriv (multiplier exp) var)
                        (multiplicand exp))))
        (else
          (error "unknown expression type: DERIV" exp))))



;;; General purpose functions.

(define (operation? op exp)
  (and (pair? exp) (eq? (car exp) op)))

(define (combine symbolic-op number-op x y)
  (cond ((and (number? x) (number? y)) (number-op x y))
        ((and (operation? symbolic-op x)
              (operation? symbolic-op y))
         (cons symbolic-op (append (cdr x) (cdr y))))
        ((operation? symbolic-op x)
         (cons symbolic-op (append (cdr x) (list y)))) ; allow for noncomm.
        ((operation? symbolic-op y)
         (cons symbolic-op (cons x (cdr y))))
        (else (list symbolic-op x y))))

(define (singleton? x)
  (and (pair? x) (null? (cdr x))))

(define (format-operation op items)
  (cond ((singleton? items) (car items))
        (else (cons op items))))

(define (get-first items)
  (cadr items))

(define (get-rest items)
  (format-operation (car items) (cddr items)))

;;; Sums

(define (make-sum x y)
  (cond ((=number? x 0) y)
        ((=number? y 0) x)
        (else (combine '+ + x y))))

(define (sum? exp)
  (operation? '+ exp))

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
