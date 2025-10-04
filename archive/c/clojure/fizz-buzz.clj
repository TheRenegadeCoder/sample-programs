(ns fizzbuzz
  (:gen-class)
  (:require [clojure.string :refer [join]]))

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

(println (fizzbuzz 100))
