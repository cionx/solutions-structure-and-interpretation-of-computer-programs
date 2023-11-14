(load "../../sicplib.scm")



(define (deriv expr var)
  (cond ((number? expr) 0)
        ((variable? expr)
         (if (same-variable? expr var) 1 0))
        ((sum? expr)
         (make-sum (deriv (addend expr) var)
                   (deriv (augend expr) var)))
        ((product? expr)
         (make-sum
          (make-product (multiplier expr)
                        (deriv (multiplicand expr) var))
          (make-product (deriv (multiplier expr) var)
                        (multiplicand expr))))
        ((power? expr)
         (let ((b (base expr))
               (n (exponent expr)))
           (make-product (make-product n (make-power b (- n 1)))
                         (deriv b var))))
        (else
          (error "unknown expression type: DERIV" expr))))

(define (make-power base exponent)
  (cond ((= exponent 0) 1)
        ((= exponent 1) base)
        ((number? base) (expt base exponent))
        (else (list '** base exponent))))

(define (power? expr)
  (and (pair? expr) (eq? (car expr) '**)))

(define (base e)
  (cadr e))

(define (exponent e)
  (caddr e))
