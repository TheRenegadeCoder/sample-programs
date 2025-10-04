USAGE := Usage: please input a non-negative integer

# Numbers are represented as x's so that they can be manipulated with text functions.
# This idea is based on how the GNU Make Standard Library (https://github.com/jgrahamc/gmsl)
# handles numbers.
X0  :=
X1  := x
X2  := x x
X3  := x x x
X4  := x x x x
X5  := x x x x x
X6  := x x x x x x
X7  := x x x x x x x
X8  := x x x x x x x x
X9  := x x x x x x x x x
X10 := x x x x x x x x x x

# Constants
NUMBERS := 0 1 2 3 4 5 6 7 8 9

# Get rest of words in a list
# Arg 1: The list
# Return: List with first word removed
REST = $(wordlist 2,$(words $(1)),$(1))

# Repeatedly apply a function
# Arg 1: Name of function. This function must take two arguments:
# - Function Arg1: Current value
# - Function Arg2: New value
# Arg 2: The list to repeated apply the function to
# Arg 3: Initial value
_REDUCE = $(if $(4),$(call _REDUCE,$(1),$(call $(1),$(2),$(3)),$(firstword $(4)),$(call REST,$(4))),$(call $(1),$(2),$(3)))
REDUCE = $(call _REDUCE,$(1),$(3),$(firstword $(2)),$(call REST,$(2)))

# Split number into individual digits
# Arg 1: Number to split
# Return: Number split into individual digits
_SUBST_SPACE = $(subst $(2), $(2),$(1))
SPLIT_NUMBER = $(strip $(call REDUCE,_SUBST_SPACE,$(NUMBERS),$(1)))

# Indicate if valid number
# Arg 1: Number
# Return: $(X1) if valid number, $(X0) otherwise
IS_VALID_NUMBER = $(if $(strip $(1)),$(if $(filter-out $(NUMBERS),$(call SPLIT_NUMBER,$(1))),$(X0),$(X1)),$(X0))

# Add function
# Arg 1: Number 1 encoded as x's
# Arg 2: Number 2 encoded as x's
# Return: Number 1 + Number 2 encoded as x's
ADD = $(strip $(1) $(2))

# Multiply function
# Arg 1: Number 1 encoded as x's
# Arg 2: Number 2 encoded as x's
# Return: Number 1 * Number 2 encoded as x's
MULT = $(strip $(foreach _,$(2),$(1)))

# Multiply first number by 10 and add second number
# Arg 1: Number 1 encoded as x's
# Arg 2: Number 2
# Return: Number1 * 10 + Number 2 encoded as x's
MULT10_ADD_N = $(call ADD,$(call MULT,$(1),$(X10)),$(X$(2)))

# Represent number as list of x's
# Arg 1: Number
# Return: Number encoded as x's
CONVERT_NUMBER = $(strip $(call REDUCE,MULT10_ADD_N,$(call SPLIT_NUMBER,$(1)),$(X0)))

# Is divisible function
# Arg 1: Number encoded as x's
# Arg 2: Divisor encoded as x's
# Return: $(X1) if divisible, $(X0) otherwise
IS_DIVISIBLE = $(if $(strip $(subst $(2),,$(1))),$(X0),$(X1))

# Increment function
# Arg 1: Number encoded as x's
# Return: Number + 1 encoded as x's
INC = $(strip $(1) $(X1))

# Is less than function
# Arg 1: Number 1 encoded as x's
# Arg 2: Number 2 encoded as x's
# Return: $(X1) if Number 1 < Number 2, $(X0) otherwise
IS_LESS_THAN = $(if $(wordlist $(words $(call INC,$(1))),$(words $(2)),$(2)),$(X1),$(X0))

# Is less than or equal function
# Arg 1: Number 1 encoded as x's
# Arg 2: Number 2 encoded as x's
# Return: $(X1) if Number 1 <= Number 2, $(X0) otherwise
IS_LESS_OR_EQUAL = $(call IS_LESS_THAN,$(1),$(call INC,$(2)))

# Is prime function
#
# If number < 2, indicate composite
# Else if number < 3, indicate prime since number must be 2
# Else if number is even, indicate composite
# Else use trail division to determine if prime
#
# Arg 1: Number to check encoded as x's
# Return: $(X1) if prime, $(X0) if composite
IS_PRIME = $(strip \
    $(if $(call IS_LESS_THAN,$(1),$(X2)),$(X0),\
        $(if $(call IS_LESS_THAN,$(1),$(X3)),$(X1),\
            $(if $(call IS_DIVISIBLE,$(1),$(X2)),$(X0),\
                $(call TRIAL_DIVISION,$(1),$(X3))\
            )\
        )\
    )\
)

# Determine if number is prime using trial division while divisor squared is
# less than or equal number, trying successive odd divisors
#
# Arg 1: Number to check encoded as x's
# Arg 2: Divisor (must be odd) encoded as x's
# Return: $(X1) if prime, $(X0) if composite
TRIAL_DIVISION = $(if $(call IS_LESS_OR_EQUAL,$(call MULT,$(2),$(2)),$(1)),\
    $(if $(call IS_DIVISIBLE,$(1),$(2)),$(X0),\
        $(call TRIAL_DIVISION,$(1),$(call ADD,$(2),$(X2)))),\
    $(X1)\
)

# If invalid number, display usage statement
# Else if indicate if number is prime or composite
ifeq (,$(call IS_VALID_NUMBER,$(ARGV1)))
$(info $(USAGE))
else
NUMBER := $(call CONVERT_NUMBER,$(strip $(ARGV1)))
$(info $(if $(call IS_PRIME,$(NUMBER)),prime,composite))
endif

.PHONY:
all: ;@:
