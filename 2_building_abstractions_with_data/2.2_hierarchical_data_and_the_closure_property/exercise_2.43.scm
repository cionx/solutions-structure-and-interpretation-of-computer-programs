;;; Copied from the book.

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (accumulate-n op init seqs)
  (if (null? (car seqs))
      '()
      (cons (accumulate op init (map car seqs))
            (accumulate-n op init (map cdr seqs)))))

(define (flatmap proc seq)
  (accumulate append '() (map proc seq)))

(define (enumerate-interval low high)
  (if (> low high)
      '()
      (cons low (enumerate-interval (+ low 1) high))))



;;; Copied from the previous exercise.

(define (make-queen row column)
  (cons row column))

(define (queen-row q)
  (car q))

(define (queen-column q)
  (cdr q))

(define empty-board '())

(define (adjoin-position new-row k rest-of-queens)
  (cons (make-queen new-row k) rest-of-queens))

(define (member? x items)
  (if (null? items)
      false
      (or (= x (car items))
          (member? x (cdr items)))))

(define (first-multiple-times? items)
  (member? (car items) (cdr items)))

(define (safe? k queens)
  (define (free-coord? coord-function)
    (not (first-multiple-times? (map coord-function queens))))
  (and (free-coord? queen-row)
       (free-coord?
         (lambda (q) (- (queen-row q) (queen-column q))))
       (free-coord?
         (lambda (q) (+ (queen-row q) (queen-column q))))))



;;; New code.

(define (queen-cols n k)
  (if (<= k 0)
      (list (list empty-board))
      (let ((earlier-results (queen-cols n (- k 1))))
        (cons
          (filter
            (lambda (positions)
              (safe? k positions))
            (flatmap
              (lambda (rest-of-queens)
                (map (lambda (new-row)
                       (adjoin-position new-row
                                        k
                                        rest-of-queens))
                     (enumerate-interval 1 n)))
              (car earlier-results)))
          earlier-results))))

(define (q-values n)
  (reverse (map length (queen-cols n (- n 1)))))

(define (weighted-q-values n)
  (map *
       (q-values n)
       (map (lambda (k) (* (+ 21 (* 23 k)) n))
            (enumerate-interval 0 (- n 1)))))

(define (sum items)
  (accumulate + 0 items))

(define (R n)
  (exact->inexact
    (let ((weighted-qs (weighted-q-values n)))
      (* (expt n n)
         (/
           (+ 1
              (sum (map /
                        weighted-qs
                        (map (lambda (k) (expt n (+ k 1)))
                             (enumerate-interval 0 (- n 1))))))
           (+ 1
              (sum weighted-qs)))))))
