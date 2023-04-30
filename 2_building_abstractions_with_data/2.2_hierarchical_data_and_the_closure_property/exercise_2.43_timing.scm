(define (queens board-size)
  (define (queen-cols k)
    (if (= k 0)
        (list empty-board)
        (filter
         (lambda (positions) (safe? k positions))
         (flatmap
          (lambda (rest-of-queens)
            (map (lambda (new-row)
                   (adjoin-position new-row
                                    k
                                    rest-of-queens))
                 (enumerate-interval 1 board-size)))
          (queen-cols (- k 1))))))
  (queen-cols board-size))

(define (queens-louis board-size)
  (define (queen-cols k)
    (if (= k 0)
        (list empty-board)
        (filter
         (lambda (positions) (safe? k positions))
         (flatmap
          (lambda (new-row)
            (map (lambda (rest-of-queens)
                   (adjoin-position new-row
                                    k
                                    rest-of-queens))
                 (queen-cols (- k 1))))
          (enumerate-interval 1 board-size)))))
         (queen-cols board-size))

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

(define (time loop-number f x)
  (define (iter remaining start-time)
    (if (> remaining 0)
        (begin (f x)
               (iter (- remaining 1) start-time))
        (- (runtime) start-time)))
  (/ (iter loop-number (runtime))
     loop-number))





(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (flatmap proc seq)
  (accumulate append '() (map proc seq)))

(define (enumerate-interval low high)
  (if (> low high)
      '()
      (cons low (enumerate-interval (+ low 1) high))))
