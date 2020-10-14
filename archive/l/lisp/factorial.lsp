(defun factorial (n)
  (if (= n 0)
      1
      (* n (factorial (- n 1))) ) )

(defun maybe-pos-int (input)
  (cond
    ((null input) nil)
    ((string= input "") nil)
    ((every #'digit-char-p input) (parse-integer input))
    (t nil)))

(defparameter num (maybe-pos-int (cadr *posix-argv*)))
(cond
  ((null num) (write-line "Usage: please input a non-negative integer"))
  (t (print (factorial num)))
)