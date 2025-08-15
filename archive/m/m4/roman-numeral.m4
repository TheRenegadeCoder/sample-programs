divert(-1)
define(`show_usage',
`Usage: please provide a string of roman numerals
m4exit(`1')')

define(`show_error',
`Error: invalid string of roman numerals
m4exit(`1')')

dnl is_valid_roman(str)
define(`is_valid_roman', `eval(regexp(`$1', `[^IVXLCDM]') < 0)')

dnl roman_value(letter)
define(`roman_value',
`ifelse(`$1', `I', `1',
    `$1', `V', `5',
    `$1', `X', `10',
    `$1', `L', `50',
    `$1', `C', `100',
    `$1', `D', `500', `1000')'dnl
)

dnl roman_numeral(str)
define(`roman_numeral',
`ifelse(is_valid_roman(`$1'), 0, `-1', `_roman_numeral(`$1', `0', `-1')')'dnl
)

dnl _roman_numeral(str, total, prev_value)
dnl for each character (ch) in str:
dnl    value = roman_letter(ch)
dnl    total = total + value
dnl    if prev_value > 0 and value > prev_value:
dnl        total = total - 2 * prev_value
dnl        value = -1
dnl    prev_value = value
dnl Return total
define(`_roman_numeral',
`ifelse(len(`$1'), 0, `$2',
`pushdef(`value', roman_value(substr(`$1', 0, 1)))dnl
ifelse(eval($3 > 0 && value > $3), 1,
    `_roman_numeral(substr(`$1', 1), eval($2 + value - 2 * $3), `-1')',
    `_roman_numeral(substr(`$1', 1), eval($2 + value), value)'dnl
)dnl
popdef(`value')'dnl
)'dnl
)
divert(0)dnl
ifelse(eval(ARGC < 1), 1, `show_usage()')dnl
ifelse(is_valid_roman(ARGV1), 0, `show_error()')dnl
define(`result', roman_numeral(ARGV1))dnl
ifelse(eval(result < 0), 1, `show_error()', `result')
