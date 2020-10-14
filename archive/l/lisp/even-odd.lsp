(defun even-odd (x)
   (cond
     ((evenp x) "Even")
     ((oddp x) "Odd")))

(defun maybe-int (input)
  (cond
    ((null input) nil)
    ((string= input "") nil)
    ((every #'digit-char-p (string-left-trim "-" input)) (parse-integer input))
    (t nil)))

(defparameter num (maybe-int (cadr *posix-argv*)))
(cond
  ((null num) (write-line "Usage: please input a number"))
  (t (write-line (even-odd num))))
