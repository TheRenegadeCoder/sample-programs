(ns baklava
  (:gen-class)
  (:require [clojure.string :refer [join]])
)

(defn repeat-string [n, s]
  (join (repeat n s))
)

(defn baklava-line [n]
  (def num-spaces (abs (- n 10)))
  (def num-stars (- 21 (* 2 num-spaces)))
  (str (repeat-string num-spaces " ") (repeat-string num-stars "*"))
)

(defn baklava [n]
  (join "\n" (map baklava-line (range 0 n)))
)

(println (baklava 21))
