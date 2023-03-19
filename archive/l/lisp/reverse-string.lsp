(defparameter input (cadr *posix-argv*))
(cond
  ((null input) ())
  (t (write-line (reverse input)))
)
