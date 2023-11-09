(define (make-mobile left right)
  (list left right))

(define (make-branch length structure)
  (list length structure))



;;; a.

(define (left-branch mobile)
  (car mobile))

(define (right-branch mobile)
  (cadr mobile))

(define (branch-length branch)
  (car branch))

(define (branch-structure branch)
  (cadr branch))

;;; auxiliary procedures

(define (mobile? structure)
  (pair? structure))

(define (weight? structure)
  (number? structure))

(define (left-structure mobile)
  (branch-structure (left-branch mobile)))

(define (right-structure mobile)
  (branch-structure (right-branch mobile)))


;;; b.

(define (total-weight structure)
  (if (mobile? structure)
      (+ (total-weight (left-structure structure))
         (total-weight (right-structure structure)))
      structure))


;;; c.

(define (branch-torque branch)
  (* (branch-length branch)
     (total-weight (branch-structure branch))))

(define (top-balanced? mobile)
  (= (branch-torque (left-branch mobile))
     (branch-torque (right-branch mobile))))

(define (balanced? structure)
  (if (mobile? structure)
      (and (top-balanced? structure)
           (balanced? (left-structure structure))
           (balanced? (right-structure structure)))
      #t))
