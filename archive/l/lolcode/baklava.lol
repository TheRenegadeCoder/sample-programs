HAI 1.2

BTW Function to output a string n times
HOW IZ I OUTPUT_N_TIMES_FOR YR string AN YR n
  IM IN YR loop UPPIN YR i TIL BOTH SAEM i AN BIGGR OF i AN n
    VISIBLE ":{string}"!
  IM OUTTA YR loop
IF U SAY SO

BTW For n = 0 to 20
IM IN YR loop UPPIN YR n TIL BOTH SAEM n AN BIGGR OF n AN 21
  BTW num_spaces = abs(n - 10)
  I HAS A num_spaces ITZ DIFF OF n AN 10
  DIFFRINT num_spaces AN BIGGR OF 0 AN num_spaces
  O RLY?
    YA RLY
      num_spaces R PRODUKT OF -1 AN num_spaces
  OIC

  BTW num_stars = 21 - 2 * num_spaces
  I HAS A num_stars ITZ DIFF OF 21 AN PRODUKT OF 2 AN num_spaces

  BTW Output " " num_spaces times
  I IZ OUTPUT_N_TIMES_FOR YR " " AN YR num_spaces MKAY

  BTW Output "*" num_stars times
  I IZ OUTPUT_N_TIMES_FOR YR "*" AN YR num_stars MKAY

  BTW Output newline
  VISIBLE ""
IM OUTTA YR loop

KTHXBYE
