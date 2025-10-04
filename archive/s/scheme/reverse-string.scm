(define (reverse-string x)
  (list->string (reverse (string->list x))))

(if (> (length (command-line)) 1)
  (display (reverse-string (list-ref (command-line) 1)))
)
