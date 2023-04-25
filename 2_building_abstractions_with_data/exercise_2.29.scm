(define (make-mobile left right)
  (list left right))

(define (make-branch length structure)
  (list length structure))




(define (left-branch mobile)
  (car mobile))

(define (right-branch mobile)
  (cadr mobile))

(define (branch-length branch)
  (car branch))

(define (branch-structure branch)
  (cadr branch))



(define (mobile? structure)
  (list? structure))

(define (weight? structure)
  (not (mobile? structure)))

(define (left-structure mobile)
  (branch-structure (left-branch mobile)))

(define (right-structure mobile)
  (branch-structure (right-branch mobile)))



(define (total-weight mobile)
  (define (structure-weight structure)
    (if (mobile? structure)
        (total-weight structure)
        structure))
  (+ (structure-weight (left-structure mobile))
     (structure-weight (right-structure mobile))))



(define (balanced? structure)
  (define (branch-torque branch)
    (* (branch-length branch)
       (total-weight (branch-structure branch))))
  (define (same-torque? mobile)
    (= (branch-torque (left-branch mobile))
       (branch-torque (right-branch mobile))))
  (or (weight? structure)
      (and (same-torque? structure)
           (balanced? (left-structure structure))
           (balanced? (right-structure structure)))))



(define m
  (make-mobile
    (make-branch
      1
      (make-mobile
        (make-branch 1 1)
        (make-branch 1 2)))
    (make-branch
      1
      (make-mobile
        (make-branch 1 3)
        (make-branch 1 4)))))
