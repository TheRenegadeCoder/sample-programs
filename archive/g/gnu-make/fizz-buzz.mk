# Constants
EMPTY :=
SPACE := $(EMPTY) $(EMPTY)

# Numbers are represented as x's so that they can be manipulated with text functions.
# This idea is based on how the GNU Make Standard Library (https://github.com/jgrahamc/gmsl)
# handles numbers.
ZERO :=
ONE := x
TWO := x x
THREE := x x x
FIVE := $(THREE) $(TWO)
TEN := $(FIVE) $(FIVE)
FIFTEEN := $(TEN) $(FIVE)
HUNDRED := $(TEN) $(TEN) $(TEN) $(TEN) $(TEN) $(TEN) $(TEN) $(TEN) $(TEN) $(TEN)

# Join function
# Arg 1: String
# Return: String without spaces
JOIN = $(subst $(SPACE),,$1)

# Is divisible function
# Arg 1: Number
# Arg 2: Divisor
# Return: $(ONE) if divisible, $(ZERO) otherwise
IS_DIVISIBLE = $(if $(subst $(call JOIN,$2),,$(call JOIN,$1)),$(ZERO),$(ONE))

# Is less than function
# Arg 1: Number 1
# Arg 2: Number 2
# Return: $(ONE) if Number 1 < Number 2, $(ZERO) otherwise
IS_LESS_THAN = $(if $(wordlist $(words $(call INC,$(1))),$(words $(2)),$(2)),$(ONE),$(ZERO))

# Increment function
# Arg 1: Number
# Return: Number + 1
INC = $(1) $(ONE)

# Fizz Buzz function
# Arg 1: Number
# Return: One of the following:
# - FizzBuzz if Number is divisible by 15
# - Fizz if Number is divisible by 3
# - Buzz if Number if divisible 5
# - Otherwise, Number converted to decimal representation
FIZZ_BUZZ = $(strip \
    $(if $(call IS_DIVISIBLE,$(1),$(FIFTEEN)),FizzBuzz,\
        $(if $(call IS_DIVISIBLE,$(1),$(THREE)),Fizz,\
            $(if $(call IS_DIVISIBLE,$(1),$(FIVE)),Buzz,$(words $(1)))\
        ) \
    ) \
)

# Fizz Buzz loop
#
# Outputs result of Fizz Buzz function start a specified number and end at the ending number.
#
# Arg 1: Starting number
# Arg 2: Ending number
define FIZZ_BUZZ_LOOP
$(info $(call FIZZ_BUZZ,$(1)))
$(if $(call IS_LESS_THAN,$(1),$(2)),$(call FIZZ_BUZZ_LOOP,$(call INC,$(1)),$(2)))
endef

# Run Fizz Buzz loop from 1 to 100
$(call FIZZ_BUZZ_LOOP,$(ONE),$(HUNDRED))

.PHONY: all
all: ;@:
