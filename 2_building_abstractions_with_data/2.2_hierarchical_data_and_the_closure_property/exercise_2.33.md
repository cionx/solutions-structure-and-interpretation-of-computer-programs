# Exercise 2.33

> Fill in the missing expressions to complete the following definitions of some basic list-manipulation operations as accumulations:
> ```scheme
> (define (map p sequence)
>   (accumulate (lambda (x y) ⟨??⟩) nil sequence))
>
> (define (append seq1 seq2)
>   (accumulate cons ⟨??⟩ ⟨??⟩))
>
> (define (length sequence)
>   (accumulate ⟨??⟩ 0 sequence))
> ```



The procedure `accumulate` works in a right-associative way.
Keeping that in mind, we can express the three listed operations as follows:
```scheme
(define (map f sequence)
  (accumulate (lambda (x items) (cons (f x) items))
              '()
              sequence))

(define (append seq1 seq2)
  (accumulate cons seq2 seq1))

(define (length sequence)
  (accumulate (lambda (x y) (+ y 1)) 0 sequence))
```
