;This program will determine even/odd in LISP

(defun EvenOdd()
	(terpri)
	(princ "Enter Number: ")
	(setq num (read))
	(setq leftover (mod num 2))
	(terpri)
	(princ "The mod version is: ")
	(write leftover)
	(if (= 0 leftover)
		(format t "~% num is even."))
	
	(terpri)
)

(EvenOdd)
