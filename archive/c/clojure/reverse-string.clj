(ns reverse-string
	(:gen-class))

(defn reverse [s]
  (clojure.string/reverse s))

(reverse "Hello, World")