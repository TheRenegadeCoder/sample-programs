(ns capitalize
	(:gen-class))

(defn- is-valid-input [args]
  (and 
    (not= (count args) 0) 
    (not= (first args) "")))

(defn- print-error []
  (println "Usage: please provide a string"))

(defn- capitalize [s]
  (str 
    (clojure.string/upper-case 
      (subs s 0 1)) (subs s 1)
  ))

(defn main [args]
  (if (is-valid-input args) 
    (println (capitalize (first args)))
    (print-error)
  ))


(main *command-line-args*)
