# Exercise 2.39

> Complete the following definitions of `reverse` (Exercise 2.18) in terms of `fold-right` and `fold-left` from Exercise 2.38:
> ```scheme
> (define (reverse sequence)
>   (fold-right (lambda (x y) ⟨??⟩) nil sequence))
>
> (define (reverse sequence)
>   (fold-left (lambda (x y) ⟨??⟩) nil sequence))
> ```



We can use the following code:
```scheme
(define (reverse sequence)
  (fold-right (lambda (x rest) (append rest (list x)))
              '()
              sequence))

(define (reverse sequence)
  (fold-left (lambda (previous x) (cons x previous))
             '()
             sequence))
```
