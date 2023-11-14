(load "../../sicplib.scm")

(define (atom? expr)
  (or (number? expr) (variable? expr)))

(define (precedence expr)
  (cond ((and (atom? expr) (eq? expr '+)) 1)
        ((and (atom? expr) (eq? expr '*)) 2)
        (else 3)))

;; Finds the item with the lowest precende;
;; if multiple items have lowest precedence,
;; then the first find is returned.
(define (find-lowest expr)
  (define (iter lowest-so-far rest-combination)
    (if (null? rest-combination)
        lowest-so-far
        (let ((head (car rest-combination))
              (tail (cdr rest-combination)))
          (let ((new-lowest (if (< (precedence head)
                                   (precedence lowest-so-far))
                                head
                                lowest-so-far)))
            (iter new-lowest tail)))))
  (cond ((null? expr)
         (error "Error: cannot find a lowest-precedence atom in an empty expression"))
        ((atom? expr) expr)
        (else (iter (car expr) (cdr expr)))))

(define (total-precedence expr)
  (precedence (find-lowest expr)))

(define (operation? op expr)
  (eq? op (find-lowest expr)))

(define (parentisize expr)
  (if (pair? expr) expr (list expr)))

(define (combine symbolic-op number-op x y)
  (define (make-items-list z)
    (cond ((< (total-precedence z)
              (precedence symbolic-op))
           (list (parentisize z)))
          ((atom? z) (list z))
          (else z)))
  (if (and (number? x) (number? y))
      (number-op x y)
      (append (make-items-list x)
              (cons symbolic-op
                    (make-items-list y)))))

(define (singleton? x)
  (and (pair? x) (null? (cdr x))))

(define (unpack-singleton item)
  (if (singleton? item) (car item) item))

(define (get-first op expr)
  (define (get-first-as-list expression)
    (if (or (null? expression)
            (eq? op (car expression)))
        '()
        (cons (car expression)
              (get-first-as-list (cdr expression)))))
  (unpack-singleton (get-first-as-list expr)))

(define (get-rest op expr)
  (define (get-rest-as-list expression)
    (cond ((null? expression) '())
          ((eq? (car expression) op) (cdr expression))
          (else (get-rest-as-list (cdr expression)))))
  (unpack-singleton (get-rest-as-list expr)))

;;; Sums

(define (make-sum x y)
  (cond ((=number? x 0) y)
        ((=number? y 0) x)
        (else (combine '+ + x y))))

(define (sum? expr)
  (operation? '+ expr))

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

(define (product? expr)
  (operation? '* expr))

(define (multiplier product)
  (get-first '* product))

(define (multiplicand product)
  (get-rest '* product))
