# Exercise 2.74

> Insatiable Enterprises, Inc., is a highly decentralized conglomerate company consisting of a large number of independent divisions located all over the world.
> The company’s computer facilities have just been interconnected by means of a clever network-interfacing scheme that makes the entire network appear to any user to be a single computer.
> Insatiable’s president, in her first attempt to exploit the ability of the network to extract administrative information from division files, is dismayed to discover that, although all the division files have been implemented as data structures in Scheme, the particular data structure used varies from division to division.
> A meeting of division managers is hastily called to search for a strategy to integrate the files that will satisfy headquarters’ needs while preserving the existing autonomy of the divisions.
>
> Show how such a strategy can be implemented with data-directed programming.
> As an example, suppose that each division’s personnel records consist of a single file, which contains a set of records keyed on employees’ names.
> The structure of the set varies from division to division.
> Furthermore, each employee’s record is itself a set (structured differently from division to division) that contains information keyed under identifiers such as `address` and `salary`.
> In particular:
>
> 1.  Implement for headquarters a `get-record` procedure that retrieves a specified employee’s record from a specified personnel file.
>     The procedure should be applicable to any division’s file.
>     Explain how the individual divisions’ files should be structured.
>     In particular, what type information must be supplied?
>
> 2.  Implement for headquarters a `get-salary` procedure that returns the salary information from a given employee’s record from any division’s personnel file.
>     How should the record be structured in order to make this operation work?
>
> 3.  Implement for headquarters a `find-employee-record` procedure.
>     This should search all the divisions’ files for the record of a given employee and return the record.
>     Assume that this procedure takes as arguments an employee’s name and a list of all the divisions’ files.
>
> 4.  When Insatiable takes over a new company, what changes must be made in order to incorporate the new personnel information into the central system?

---

We assume that each division has the following:

- A `division-file` holding the set of records for the division, in some data structure.

- A procedure `(division-get-record division-file ⟨name⟩)` that takes as arguments the record-file `division-file`, the `⟨name⟩` of an employee of the division (as a symbol), and that returns the employee’s record.
  If no record could be found, then a failure-value `⟨division-record-failure⟩` is returned instead.

- A procedure `(divison-get-value ⟨record⟩ ⟨attribute⟩)` that takes as arguments an employee record and an attribute (as a symbol) whose value we want to find in the record (e.g., `'address` or `'salary`), and that returns the value of the specified attribute.
  If the attribute could not be found in the record, then a failure-value `⟨division-attribute-failure⟩` is returned instead.

- A `division-name`, which is represented as a symbol, and that uniquely identifies the division (e.g., `'sales`, `'development`, `'human-resources`).

We then require each division to do the following:

- Tag their record file with their division name, as well as each individual record:
  ```scheme
  (define (tag-division-file division-name division-file)
    (attach-tag division-name
                (map (lambda (rec) (attach-tag division-name rec))
                     division-file)))
  ```

- Register the procedure they use to get records from their respective record file:
  ```scheme
  (put 'get-record division-name division-get-record)
  ```
  Also register the failure-value for their procedure:
  ```scheme
  (put 'record-failure division-name division-record-failure)
  ```

- Register their procedure for getting attributes for global use:
  ```scheme
  (put 'get-value division-name division-get-value)
  ```
  Also register the failure-value for their procedure:
  ```scheme
  (put 'value-failure division-name division-value-failure)
  ```

To get a record from a specified tagged record file, we first look up which division the record file belongs to, and then look up the suitable procedure that this division uses:
```scheme
(define (get-record file name)
  (let ((division (type-tag file)))
    (let ((result ((get 'get-record division)
                   (map contents (contents file))
                   name)))
      (if (eq? result (get 'record-failure division))
          #f
          (attach-tag division result)))))
```
To then get the attribute from a tagged record, we can use a similar procedure:
```scheme
(define (get-value rec attr)
  (let ((division (type-tag rec)))
    (let ((result ((get 'get-value division)
                   (contents rec)
                   attr)))
      (if (eq? result (get 'value-failure division))
          #f
          result))))
```
We can search for an employee in a list of record files by iterating through the list and using `get-record`:
```scheme
(define (find-record file-list name)
  (define (iter fs)
    (if (null? fs)
        #f
        (let ((result (get-record (car fs) name)))
          (if (eq? result #f)
              (iter (cdr fs))
              result))))
  (iter file-list))
```

When the company assimilates another victim, then the new division will need to do the following:

- Be assigned a name that is distinct from all division names already in use.

- Tag their record file with their assigned name, as well as all the records within it.

- Register their procedures for getting records from their record file, getting attributes from their records, and their failure values for these procedures.
