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



(define (atom? expr)
  (or (number? expr)
      (variable? expr)))

(define (operation? op exp)
  (eq? op (find-lowest exp)))

(define (precedence atom)
  (cond ((eq? atom '+) 1)
        ((eq? atom '*) 2)
        (else 3)))

;; Finds the item with the lowest precende;
;; if multiple items have lowest precedence,
;; then the first find is returned.
(define (find-lowest exp)
  (define (iter lowest-so-far rest-exp)
    (if (null? rest-exp)
        lowest-so-far
        (let ((head (car rest-exp))
              (tail (cdr rest-exp)))
          (iter (if (< (precedence head)
                       (precedence lowest-so-far))
                    head
                    lowest-so-far)
                tail))))
  (cond ((null? exp)
         (error "Error: cannot find a lowest-precedence atom in an empty expression"))
        ((atom? exp) exp)
        (else (iter (car exp) (cdr exp)))))

(define (total-precedence exp)
  (precedence (find-lowest exp)))

(define (parentisize exp)
  (if (pair? exp) exp (list exp)))

(define (combine symbolic-op number-op x y)
  (if (and (number? x) (number? y))
      (number-op x y)
      (let ((p (precedence symbolic-op)))
        (define (make-items-list z)
          (cond ((< (total-precedence z) p)
                 (list (parentisize z)))
                ((atom? z) (list z))
                (else z)))
        (append (make-items-list x)
                (cons symbolic-op
                      (make-items-list y))))))

(define (singleton? x)
  (and (pair? x) (null? (cdr x))))

(define (unpack-singleton input)
  (if (singleton? input) (car input) input))

(define (get-first op exp)
  (define (get-first-list expression)
    (if (or (null? expression)
            (eq? op (car expression)))
        '()
        (cons (car expression)
              (get-first-list (cdr expression)))))
 (unpack-singleton (get-first-list exp)))

(define (get-rest op exp)
  (define (get-rest-list expression)
    (cond ((null? expression) '())
          ((eq? (car expression) op) (cdr expression))
          (else (get-rest-list (cdr expression)))))
  (unpack-singleton (get-rest-list exp)))

;;; Sums

(define (make-sum x y)
  (cond ((=number? x 0) y)
        ((=number? y 0) x)
        (else (combine '+ + x y))))

(define (sum? exp)
  (operation? '+ exp))

(define (addend sum)
  (get-first '+ sum))

(define (augend sum)
  (get-rest '+ sum))

;;; Products

(define (make-product x y)
  (cond ((or (=number? x 0) (=number? y 0)) 0)
        ((=number? x 1) y)
        ((=number? y 1) x)
        (else (combine '* * x y))))

(define (product? exp)
  (operation? '* exp))

(define (multiplier product)
  (get-first '* product))

(define (multiplicand product)
  (get-rest '* product))
