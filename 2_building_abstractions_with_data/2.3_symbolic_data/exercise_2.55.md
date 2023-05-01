# Exercise 2.55

> Eva Lu Ator types to the interpreter the expression
> ```scheme
> (car ''abracadabra)
> ```
> To her surprise, the interpreter prints back `quote`.
> Explain.



The rules for quotes seem to be as follows:

- The expression `'⟨stuff⟩` is _always_ syntactic sugar for `(quote ⟨stuff⟩)`:
  we can make this replacement in every situation.

- Quoting a primitive value (integer, string, boolean, …) does nothing.
  For example, `'1` is just the integer `1`.
  Consequently, `(integer? '1)` evaluates to `#t`, whereas `(symbol? '1)` evaluates to `#f`.

- Quoting an identifier (i.e., a sequence of characters that is a permissible variable name) results in a symbol.

- Quotes of the form `'(⟨stuff 1⟩ … ⟨stuff n⟩)` are treated as a list, with quotation applied to every list element:
  `(list '⟨stuff 1⟩ … '⟨stuff n⟩)`.
  So, for example, `'(1 b 3)` is evaluated to `(list '1 'b '2)`, which is further evaluated to `(list 1 b 2)`, where `1` and `2` are integers and `b` is a symbol.

- The previous point entails that `quote` does not follow the usual rules of applicative evaluation:
  normally, to evaluate an expression `(f (+ 1 2)`, we would first evaluate `(+ 1 2)` to `3`, and then further evaluate `(f 3)`.
  But `(quote (+ 1 2))` is supposed to result in `(list '+ '1 '2)` (a list of length three consisting of a symbol and two integers), and _not_ `(quote 3)` (which would be the integer `3`).

  Therefore, `quote` cannot be a procedure, but must instead be a special form:
  when evaluating `(quote ⟨stuff⟩)`, we make no effort to evaluate `⟨stuff⟩`, but instead apply the outer `quote` to the sequence of characters in `⟨stuff⟩`.

Instead of the given expression `''abracadabra` we will use `''x` to make things easier to write and read.

The expression
```scheme
''x
```
is desugared as follows:
```scheme
(quote (quote x))
```
As noted above, the `quote` is a special form, so that the outer `quote` is evaluated first.
As also noted above, this results in the following list:
```scheme
(list 'quote 'x)
```
The sequences of characters `quote` and `x` are both permissible identifiers, whence `'quote` and `'x` gives us two symbols `quote` and `x`.
Overall, `(quote (quote x))` is therefore a list of length two, consisting of the two symbols `quote` and `x` in that order.

Applying `car` to `''x` gives us the first entry of this list, which is the symbol `quote`.
