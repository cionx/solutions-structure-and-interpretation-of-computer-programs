# Exercise 2.25

> Give combinations of `car`s and `cdr`s that will pick $7$ from each of the following lists:
> ```scheme
> (1 3 (5 7) 9)
>
> ((7))
>
> (1 (2 (3 (4 (5 (6 7))))))
> ```


For the list `(1 3 (5 7) 9` we can use the following combination:
```scheme
(car (cdr (car (cdr (cdr ⟨list⟩)))))
```
For the list `((7))` we can use the following combination, or its short form:
```scheme
(car (car ⟨list⟩))

(caar ⟨list⟩)
```
For the list `(1 (2 (3 (4 (5 (6 7))))))` we can use the following combination, and its slightly shorter form::
```scheme
(car (cdr (car (cdr (car (cdr (car (cdr (car (cdr (car (cdr ⟨list⟩))))))))))))

(cadr (cadr (cadr (cadr (cadr (cadr ⟨list⟩))))))

(cadadr (cadadr (cadadr ⟨list⟩)))
```
