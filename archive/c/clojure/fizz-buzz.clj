(ns fizzbuzz
  (:gen-class)
  (:require [clojure.string :refer [join]]))

(defn- is-valid-input [args]
  (and
    (not= (count args) 0)
    (not= (Integer/parseUnsignedInt args) nil)))

(defn- print-error []
  (println "Usage: please provide a number"))

(defn- is-multiple-of-3 [n]
  (= (mod n 3) 0))

(defn- is-multiple-of-5 [n]
  (= (mod n 5) 0))

(defn- n-to-str [n]
  (def fizz-str (if (is-multiple-of-3 n) "Fizz" ""))
  (def buzz-str (if (is-multiple-of-5 n) "Buzz" ""))
  (def fizz-buzz-str (str fizz-str buzz-str))
  (def n-str (if (= fizz-buzz-str "") (str n) ""))
  (str fizz-buzz-str n-str))

(defn- fizzbuzz [n]
  (join "\n" (map n-to-str (range 1 (+ n 1)))))

(defn main [args]
  (if (is-valid-input args)
    (println (fizzbuzz (Integer/parseUnsignedInt args)))
    (print-error)
    ))

(main (first *command-line-args*))