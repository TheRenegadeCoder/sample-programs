(ns reverse-string
	(:gen-class))

(defn main [args]
  (if (not= (count args) 0)
    (println(clojure.string/reverse (first args)))
  ))

(main *command-line-args*)
