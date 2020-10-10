(defun factorial (n)
  (if (= n 0)
      1
      (* n (factorial (- n 1))) ) )

(defparameter num -1)
(defparameter input (car (cdr *posix-argv*)))
(if (not (null input))
  (defparameter num (parse-integer input :junk-allowed t)))

(if (or (null num) (< num 0))
  (write-line "Usage: please input a non-negative integer")
  (write-line (princ-to-string (factorial num)))
)