(ns capitalize
	(:gen-class))

(defn- is-valid-input [args]
  (and 
    (not= (count args) 0) 
    (not= (first args) "")))

(defn- print-error []
  (println "Usage: please provide a string"))

(defn main [args]
  (if (is-valid-input args) 
    (println(clojure.string/capitalize (first args)))
    (print-error)
  ))

(main *command-line-args*)
