(defun factorial (n)
  (if (= n 0)
      1
      (* n (factorial (- n 1))) ) )

(loop for i from 0 to 16
   do (format t "~D! = ~D~%" i (factorial i)) )