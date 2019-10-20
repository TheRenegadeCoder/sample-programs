(ns reverse-string
	(:gen-class))

(defn main [s]
  (println(clojure.string/reverse s)))

(main (first *command-line-args*))