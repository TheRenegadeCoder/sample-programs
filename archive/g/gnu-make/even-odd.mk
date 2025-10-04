USAGE := Usage: please input a number

# Numbers are represented as x's so that they can be manipulated with text functions.
# This idea is based on how the GNU Make Standard Library (https://github.com/jgrahamc/gmsl)
# handles numbers.
X0  :=
X1  := x

# Constants
NUMBERS := 0 1 2 3 4 5 6 7 8 9
EVEN_NUMBERS := 0 2 4 6 8

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

# Indicate if number is even or odd
# Arg 1: Number
# Return: $(X1) if even, $(X0) otherwise
IS_EVEN = $(if $(filter $(EVEN_NUMBERS),$(lastword $(call SPLIT_NUMBER,$(1)))),$(X1),$(X0))

# Remove leading minus sign from input value
ABS_VALUE := $(patsubst -%,%,$(ARGV1))

# If invalid number, display usage statement
# Else if indicate if number is even or odd
ifeq (,$(call IS_VALID_NUMBER,$(ABS_VALUE)))
$(info $(USAGE))
else
$(info $(if $(call IS_EVEN,$(ABS_VALUE)),Even,Odd))
endif

.PHONY:
all: ;@:
