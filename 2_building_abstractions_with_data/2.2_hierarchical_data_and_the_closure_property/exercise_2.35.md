# Exercise 2.35

> Redefine `count-leaves` from Section 2.2.2 as an accumulation:
> ```scheme
> (define (count-leaves t)
>   (accumulate ⟨??⟩ ⟨??⟩ (map ⟨??⟩ ⟨??⟩)))
> ```



We can complete the code as follows:
```scheme
(define (count-leaves tree)
  (accumulate +
              0
              (map (lambda (t)
                     (if (list? t) (count-leaves t) 1))
                   tree)))
```
