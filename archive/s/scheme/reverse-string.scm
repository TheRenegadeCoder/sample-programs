(define(reverse-string x)
  (list->string (reverse (string->list x))))

(display (reverse-string (read-line)))
