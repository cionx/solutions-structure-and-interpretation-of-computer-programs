# Exercise 2.39

> Complete the following definitions of `reverse` (Exercise 2.18) in terms of `fold-right` and `fold-left` from Exercise 2.38:
> ```scheme
> (define (reverse sequence)
>   (fold-right (lambda (x y) ⟨??⟩) nil sequence))
>
> (define (reverse sequence)
>   (fold-left (lambda (x y) ⟨??⟩) nil sequence))
> ```

---

With `fold-right` we can proceed as follows:
```scheme
(define (reverse sequence)
  (fold-right (lambda (x rest-reversed)
                (append rest-reversed (list x)))
              '()
              sequence))
```
With `fold-left` we can proceed as follows:
```scheme
(define (reverse sequence)
  (fold-left (lambda (previous-reversed x)
               (cons x previous-reversed))
             '()
             sequence))
```
