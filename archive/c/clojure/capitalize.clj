(ns capitalize
	(:gen-class))

(defn main [s]
  (println(clojure.string/capitalize s)))

(main (first *command-line-args*))
