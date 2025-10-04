;;Taken from the Common Lisp Cookbook Project (strings page)
(defun split-string (string)
    (loop for i = 0 then (1+ j)
          as j = (position #\Space string :start i)
          collect (subseq string i j)
          while j))

(defun join-string (lst)
  (when lst
    (concatenate 'string (car lst) " " (join-string (cdr lst)))))

 (defun capitalize (str)
   (concatenate 'string
     (string-upcase (subseq str 0 1)) (subseq str 1)))

(defparameter input (split-string (cadr *posix-argv*)))
(cond
  ((= (length (car input)) 0) (write-line "Usage: please provide a string"))
  (t (write-line (join-string (cons (capitalize (car input)) (cdr input))))))
