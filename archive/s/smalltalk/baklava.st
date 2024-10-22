-10 to: 10 do: [ :i |
  numSpaces := i abs.
  numSpaces timesRepeat: [ ' ' display ].
  (21 - (2 * numSpaces)) timesRepeat: [ '*' display ].
  Character nl display.
]
