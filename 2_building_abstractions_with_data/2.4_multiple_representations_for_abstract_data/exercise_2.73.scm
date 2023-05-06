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

(define (variable? x) (symbol? x))
(define (same-variable? v1 v2)
  (and (variable? v1) (variable? v2) (eq? v1 v2)))

(define (=number? exp num)
  (and (number? exp) (= exp num)))

(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp)
         (if (same-variable? exp var) 1 0))
        (else
         ((get 'deriv (operator exp)) (operands exp) var))))



;;; Code

(define (operator exp) (type-tag exp))
(define (operands exp) (contents exp))

(define (make-sum a1 a2)
  (cond ((=number? a1 0) a2)
        ((=number? a2 0) a1)
        ((and (number? a1) (number? a2)) (+ a1 a2))
        (else (attach-tag '+ (list a1 a2)))))
(define (sum? x) (eq? (type-tag x) '+))
(define (addend s) (car (contents s)))
(define (augend s) (cadr (contents s)))

(define (make-product m1 m2)
  (cond ((or (=number? m1 0) (=number? m2 0)) 0)
        ((=number? m1 1) m2)
        ((=number? m2 1) m1)
        ((and (number? m1) (number? m2)) (* m1 m2))
        (else (attach-tag '* (list m1 m2)))))
(define (product? x) (eq? (type-tag x) '*))
(define (multiplier p) (car (contents p)))
(define (multiplicand p) (cadr (contents p)))

(define (make-exponentiation b n)
  (cond ((= n 0) 1)
        ((= n 1) b)
        ((number? b) (expt b n))
        (else (attach-tag '** (list b n)))))
(define (exponentiation? x) (eq? (type-tag x) '**))
(define (base e) (car (contents e)))
(define (exponent e) (cadr (contents e)))

(define (install-deriv-package)
  ;; internal procedures
  (define (deriv-add expressions var)
    (make-sum (deriv (car expressions) var)
              (deriv (cadr expressions) var)))
  (define (deriv-mul expressions var)
    (let ((exp1 (car expressions))
          (exp2 (cadr expressions)))
      (make-sum
       (make-product exp1 (deriv exp2 var))
       (make-product (deriv exp1 var) exp2))))
  (define (deriv-pow arguments var)
    (let ((base (car arguments))
          (n (cadr arguments)))
      (make-product n (make-product
                       (make-exponentiation base (- n 1))
                       (deriv base var)))))
  ;; interface to the rest of the system
  (put 'deriv '+ deriv-add)
  (put 'deriv '* deriv-mul)
  (put 'deriv '** deriv-pow)
  'done)

;;; For testing

(install-deriv-package)

(define p '(+ (** x 2) (* 3 x)))
