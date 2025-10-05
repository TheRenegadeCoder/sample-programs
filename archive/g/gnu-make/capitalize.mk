USAGE := Usage: please provide a string

# Letter constants
LOWERCASE_LETTERS := a b c d e f g h i j k l m n o p q r s t u v w x y z
UPPERCASE_LETTERS := A B C D E F G H I J K L M N O P Q R S T U V W X Y Z
LETTER_INDEXES := 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26

# Space replacement constants
EMPTY :=
SPACE := $(EMPTY) $(EMPTY)
SPACE_REPLACEMENT := «

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

# Replace spaces in a string with a replacement character to prevent it from being treated
# as a separate word
# Arg 1: The string
# Return: The string with space replaced
REPLACE_SPACE = $(subst $(SPACE),$(SPACE_REPLACEMENT),$(1))

# Restore spaces in a string
# Arg 1: The string with space replacements
# Return: The string with space replacements converted to spaces
RESTORE_SPACE = $(subst $(SPACE_REPLACEMENT),$(SPACE),$(1))

# Capitalize the first letter of a string
# Arg 1: The string
# Return First letter of string capitalized if it is a lowercase letter. Otherwise,
#   string is unchanged
_CAPITALIZE_LETTER = $(patsubst $(word $(2),$(LOWERCASE_LETTERS))%,$(word $(2),$(UPPERCASE_LETTERS))%,$(1))
CAPITALIZE = $(call RESTORE_SPACE,$(call REDUCE,_CAPITALIZE_LETTER,$(LETTER_INDEXES),$(call REPLACE_SPACE,$(1))))

# If arguments, display usage statement
# Else display capitalized string
ifeq (,$(ARGV1))
$(info $(USAGE))
else
$(info $(call CAPITALIZE,$(ARGV1)))
endif

.PHONY:
all: ;@:
