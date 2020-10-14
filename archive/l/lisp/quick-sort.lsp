(defun qsort (L)
  (cond
    ((null L) nil)
    (t
      (append
        (qsort (list< (car L) (cdr L)))
        (cons (car L) nil) 
        (qsort (list>= (car L) (cdr L)))))))

(defun list< (a b)
  (cond
    ((or (null a) (null b)) nil)
    ((< a (car b)) (list< a (cdr b)))
    (t (cons (car b) (list< a (cdr b))))))

(defun list>= (a b)
  (cond
    ((or (null a) (null b)) nil)
    ((>= a (car b)) (list>= a (cdr b)))
    (t (cons (car b) (list>= a (cdr b))))))

;;Taken from the Common Lisp Cookbook Project (strings page)
(defun split-string (string)
    (loop for i = 0 then (1+ j)
          as j = (position #\, string :start i)
          collect (subseq string i j)
          while j))

(defun join-string (lst)
  (reduce
    (lambda (acc n)
      (concatenate 'string acc ", " (princ-to-string n))) (cdr lst)
        :initial-value (princ-to-string (car lst))))

(defun maybe-int (input)
  (cond
    ((null input) nil)
    ((string= input "") nil)
    ((every #'digit-char-p (string-left-trim "-" input)) (parse-integer input))
    (t nil)))

(defun maybe-int-list (input-list &optional (acc))
  (cond
    ((<= (length input-list) 0) acc)
    (t
      (let ((i (maybe-int (string-trim " " (car input-list)))))
        (cond
          ((null i) nil)
          (t (maybe-int-list (cdr input-list) (cons i acc))))))))


(defparameter input (maybe-int-list (split-string (cadr *posix-argv*))))
(cond
  ((or (null input) (= (length input) 1)) (write-line "Usage: please provide a list of at least two integers to sort in the format \"1, 2, 3, 4, 5\""))
  (t (write-line (join-string (qsort input)))))