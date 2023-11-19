(load "exercise_2.82.scm")

(put-coercion 'num1 'num2 (lambda (x) (attach-tag 'num2 (contents x))))
(put-coercion 'num1 'num3 (lambda (x) (attach-tag 'num3 (contents x))))
(put-coercion 'num2 'num3 (lambda (x) (attach-tag 'num3 (contents x))))

(define (product-3 x y z) (* x y z))
(put 'product '(num1 num2 num3) product-3)

(define (sum-3 x y z) (+ x y z))
(put 'sum '(num3 num3 num3) sum-3)

(define x (attach-tag 'num1 1))
(define y (attach-tag 'num2 2))
(define z (attach-tag 'num3 3))

(newline)
(display "x:   ")
(display x)
(newline)
(display "y:   ")
(display y)
(newline)
(display "z:   ")
(display z)
(newline)
(display "add: ")
(display (apply-generic 'sum x y z))
(newline)
(display "mul: ")
(display (apply-generic 'product x y z))
