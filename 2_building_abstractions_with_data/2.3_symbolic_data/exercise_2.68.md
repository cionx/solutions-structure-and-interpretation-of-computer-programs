# Exercise 2.68

> The `encode` procedure takes as arguments a message and a tree and produces the list of bits that gives the encoded message.
> ```scheme
> (define (encode message tree)
>   (if (null? message)
>       '()
>       (append (encode-symbol (car message) tree)
>               (encode (cdr message) tree))))
> ```
> `encode-symbol` is a procedure, which you must write, that returns the list of bits that encodes a given symbol according to a given tree.
> You should design `encode-symbol` so that it signals an error if the symbol is not in the tree at all.
> Test your procedure by encoding the result you obtained in Exercise~2.67 with the sample tree and seeing whether it is the same as the original sample message.

---

We use the following procedure:
```scheme
(define (encode-symbol sym tree)
  (define (encode-symbol-1 current-branch)
    (cond ((null? current-branch)
           (error "Cannot find symbol in an empty tree"))
          ((leaf? current-branch)
           (if (eq? sym (symbol-leaf current-branch))
               '()
               #f))
          (else
           (let ((left-result
                  (encode-symbol-1 (left-branch current-branch))))
            (if (not left-result)
                (let ((right-result
                       (encode-symbol-1 (right-branch current-branch))))
                  (if (not right-result)
                      #f
                      (cons 1 right-result)))
                (cons 0 left-result))))))
  (let ((result (encode-symbol-1 tree)))
    (if (eq? result #f)
        (error "Cannot find symbol in tree" sym)
        result)))
```

In the previous exercise we decoded `0110010101110` to `ADABBCA`.
The procedure `encode` agrees with this result:
```text
1 ]=> (encode '(A D A B B C A) sample-tree)

;Value: (0 1 1 0 0 1 0 1 0 1 1 1 0)
```
