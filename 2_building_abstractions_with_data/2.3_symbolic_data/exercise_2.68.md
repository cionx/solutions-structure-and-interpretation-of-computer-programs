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



We write `encode-symbol` as follows:
```scheme
(define (encode-symbol sym tree)
  (define (encode-symbol-1 t)
    (cond ((null? t) (error "Cannot find symbol in an empty tree"))
          ((leaf? t)
           (if (eq? sym (symbol-leaf t)) '() false))
          (else (let ((left-result (encode-symbol-1 (left-branch t))))
                  (if (eq? left-result false)
                      (let ((right-result (encode-symbol-1 (right-branch t))))
                        (if (eq? right-result false)
                            false
                            (cons 1 right-result)))
                      (cons 0 left-result))))))
  (let ((result (encode-symbol-1 tree)))
    (if (eq? result false)
        (error "Cannot find symbol " sym)
        result)))
```
In the previous exercise we decoded `0110010101110` to `ADABBCA`.
The procedure `encode` agrees with this result:
```text
1 ]=> (encode '(A D A B B C A) sample-tree)

;Value: (0 1 1 0 0 1 0 1 0 1 1 1 0)
```
