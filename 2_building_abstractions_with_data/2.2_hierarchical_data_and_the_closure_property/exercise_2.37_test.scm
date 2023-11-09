(load "exercise_2.37.scm")

(define ma (list (list 1 2) (list 3 4)))
(define mb (list (list 1 2) (list 3 4) (list 5 6)))
(define x (list 5 6))

; ma * x needs to equals (17 39)
(matrix-*-vector ma x)

; the transpose of ma needs to equal ((1 3) (2 4))
(transpose ma)

; the transpose of mb needs to equal ((1 3 5) (2 4 6))
(transpose mb)

; ma * ma needs to equal ((7 10) (15 22))
(matrix-*-matrix ma ma)
