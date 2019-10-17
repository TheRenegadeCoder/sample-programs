(ns capitalize
	(:gen-class))

(defn capitalize [s]
  (clojure.string/capitalize s))

(capitalize "a long string term")