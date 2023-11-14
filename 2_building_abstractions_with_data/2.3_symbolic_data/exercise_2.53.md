# Exercise 2.53

> What would the interpreter print in response to evaluating each of the following expressions?
> ```scheme
> (list 'a 'b 'c)
>
> (list (list 'george))
>
> (cdr '((x1 x2) (y1 y2)))
>
> (cadr '((x1 x2) (y1 y2)))
>
> (pair? (car '(a short list)))
>
> (memq 'red '((red shoes) (blue socks)))
>
> (memq 'red '(red shoes blue socks))
> ```

---



### `(list 'a 'b 'c)`

We get a list containing the three symbols `'a`, `'b'` and `'c`.
The interpreter will print this list as `(a b c)`.



### `(list (list 'george))`

The inner expression `(list 'george)` gives a list containing the single symbol `'george`.
This list will be printed as `(george)`.
The larger expression `(list (list 'george))` will therefore be printed as `((george))`.



### `(cdr '((x1 x2) (y1 y2)))`

The expression `'((x1 x2) (y1 y2))` gives a list with two elements:
the first element is the list `'(x1 x2)`, and the second element is the list `'(y1 y2)`.
The `cdr` of the overall list is the sublist starting at the second item, and thus the list containing only `'(y1 y2)`.
As `'(y1 y2)` is printed as `(y1 y2)`, the overall result will be printed as `((y1 y2))`.



### `(cadr '((x1 x2) (y1 y2)))`

Continuing the previous discussion, we now take the `car` of the single-item list `'((y1 y2))`, which is `'(y1 y2)`, and will be printed as `(y1 y2)`.



### `(pair? (car '(a short list)))`

The term `'(a short list)` gives a list of length 3, consisting of the symbols `'a`, `'short` and `'list`.
The `car` of this list is the symbol `'a`.
The expression `(pair? 'a)` then evaluates to `#f` because a symbol is never a pair.



### `(memq 'red '((red shoes) (blue socks)))`

The expression `'((red shoes) (blue socks))` gives a list whose elements are themselves lists:
the first element is the list `'(red shoes)`, the second element is the list `'(blue socks)`.
None of these two elements is `eq?` to the symbol `'red`, whence the overall expression will evaluate to `#f`.



### `(memq 'red '(red shoes blue socks))`

The expression `'(red shoes blue socks)` produces a list consisting of the four symbols `'red`, `'shoes`, `'blue` and `'socks`.
This list contains the symbol `'red` at its first position.
The sublist starting with `'red` is therefore the entire list, which will then be printed as `(red shoes blue socks)`.
