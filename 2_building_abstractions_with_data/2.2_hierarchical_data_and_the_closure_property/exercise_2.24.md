# Exercise 2.24

> Suppose we evaluate the expression `(list 1 (list 2 (list 3 4)))`.
> Give the result printed by the interpreter, the corresponding box-and-pointer structure, and the interpretation of this as a tree (as in Figure 2.6).



The result printed by the interpreter will be `(1 (2 (3 4)))`;
we can check this in `mit-scheme`:
```text
1 ]=> (list 1 (list 2 (list 3 4)))

;Value: (1 (2 (3 4)))
```

The box-pointer-structure can be depicted by the following diagram:
```text

   (1 (2 (3 4)))   ┌───┬───┐    ┌───┬───┐
───────────────────┤ ╷ │  ─┼────┤ ╷ │ ╱ │
                   └─┼─┴───┘    └─┼─┴───┘
                     │            │
                     │            │ (2 (3 4))
                     │            │
                   ┌─┴─┐        ┌─┴─┬───┐    ┌───┬───┐
                   │ 1 │        │ ╷ │  ─┼────┤ ╷ │ ╱ │
                   └───┘        └─┼─┴───┘    └─┼─┴───┘
                                  │            │
                                  │            │ (3 4)
                                  │            │
                                ┌─┴─┐        ┌─┴─┬───┐    ┌───┬───┐
                                │ 2 │        │ ╷ │  ─┼────┤ ╷ │ ╱ │
                                └───┘        └─┼─┴───┘    └─┼─┴───┘
                                               │            │
                                               │            │
                                               │            │
                                             ┌─┴─┐        ┌─┴─┐
                                             │ 3 │        │ 4 │
                                             └───┘        └───┘
```

The tree as a tree looks as follows:
```text
(1 (2 (3 4))
    ♦
   / \
  /   \
 /     \
1       ♦  (2 (3 4))
       / \
      /   \
     /     \
    2       ♦  (3 4)
           / \
          /   \
         /     \
        3       4
```
