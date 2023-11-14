# Exercise 2.66

> Implement the `lookup` procedure for the case where the set of records is structured as a binary tree, ordered by the numerical values of the keys.

---

We can implement `lookup` as follows:
```scheme
(define (lookup given-key set-of-records)
  (if (null? set-of-records)
      #f
      (let ((test-record (entry set-of-records)))
        (let ((test-key (key test-record)))
          (cond ((= given-key test-key) test-record)
                ((< given-key test-key)
                 (lookup given-key
                         (left-branch set-of-records)))
                ((> given-key test-key)
                 (lookup given-key
                         (right-branch set-of-records))))))))
```
