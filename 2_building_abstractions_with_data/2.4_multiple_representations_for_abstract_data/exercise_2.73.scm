(load "../../sicplib.scm")



;;; Given code from the book

(define (deriv expr var)
  (cond ((number? expr) 0)
        ((variable? expr)
         (if (same-variable? expr var) 1 0))
        (else
         ((get 'deriv (operator expr)) (operands expr) var))))



;;; New code

(define (operator expr) (type-tag expr))
(define (operands expr) (contents expr))

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

(define (make-power b n)
  (cond ((= n 0) 1)
        ((= n 1) b)
        ((number? b) (expt b n))
        (else (attach-tag '** (list b n)))))
(define (power? x) (eq? (type-tag x) '**))
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
      (make-product n (make-product (make-power base (- n 1))
                                    (deriv base var)))))
  ;; interface to the rest of the system
  (put 'deriv '+ deriv-add)
  (put 'deriv '* deriv-mul)
  (put 'deriv '** deriv-pow)
  'done)
