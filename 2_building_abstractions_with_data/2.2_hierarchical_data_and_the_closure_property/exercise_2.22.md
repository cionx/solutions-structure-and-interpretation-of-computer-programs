# Exercise 2.22

> Louis Reasoner tries to rewrite the first `square-list` procedure of Exercise 2.21 so that it evolves an iterative process:
> ```scheme
> (define (square-list items)
>   (define (iter things answer)
>     (if (null? things)
>         answer
>         (iter (cdr things)
>               (cons (square (car things))
>                     answer))))
>   (iter items nil))
> ```
> Unfortunately, defining `square-list` this way produces the answer list in the reverse order of the one desired.
> Why?
>
> Louis then tries to fix his bug by interchanging the arguments to `cons`:
> ```scheme
> (define (square-list items)
>   (define (iter things answer)
>     (if (null? things)
>         answer
>         (iter (cdr things)
>               (cons answer
>                     (square (car things))))))
>   (iter items nil))
> ```
> This doesn’t work either.
> Explain.



### First implementation

This is because lists are a first-in-last-out data structure.
The earlier we retrieve an item from `things`, the further behind its square will be placed in `answer`.

```text
things: a b c d …
answer:

things: b c d …
answer: a²

things: c d …
answer: b² a²

things: d …
answer: c² b² a²

things: …
answer: d² c² b² a²
```



### Second implementation

Lists are implemented via repeated `cons` as follows:
```scheme
(cons ⟨a1⟩ (cons ⟨a2⟩ (… (cons ⟨an⟩ nil)…))
```
However, the second procedure produces instead the following:
```scheme
(cons (… (cons (cons nil ⟨a1⟩) ⟨a2⟩) …) ⟨an⟩)
```
The result of the second procedure is therefore not even a list!
(Unless the input list `items` was empty to begin with.)
