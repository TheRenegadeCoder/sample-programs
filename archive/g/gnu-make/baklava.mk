# Constants
EMPTY :=
SPACE := $(EMPTY) $(EMPTY)
STAR := *

# Numbers are represented as x's so that they can be manipulated with text functions.
# This idea is based on how the GNU Make Standard Library (https://github.com/jgrahamc/gmsl)
# handles numbers.
ZERO :=
ONE := x
TWO := x x
NINE := x x x x x x x x x 
TEN := $(NINE) $(ONE)
NINETEEN := $(TEN) $(NINE)

# Booleans
TRUE := T
FALSE :=

# Increment function
# Arg 1: Number
# Return: Number + 1
INCREMENT = $(1) $(ONE)

# Decrement function
# Arg 1: Number
# Return: Number - 1 unless 0, else Number
DECREMENT = $(wordlist 2,$(words $(1)),$1)

# Add function
# Arg 1: Number 1
# Arg 2: Number 2
# Return: Number 1 + Number 2
ADD = $(1) $(2)

# Subtract function
# Arg 1: Number 1
# Arg 2: Number 2
# Return: Max(Number 1 - Number 2, 0)
SUB = $(wordlist $(words $(call INCREMENT,$(2))),$(words $(1)),$(1))

# Repeat function
# Arg 1: Character
# Arg 2: Number of repeats
# Return: Character repeated specified number of times
REPEAT = $(if $(2),$(1)$(call REPEAT,$(1),$(call DECREMENT,$(2))))

# Baklava line function
# Arg 1: Number of spaces
# Arg 2: Number of stars
# Return: Spaces concatentate with spaces
BAKLAVA_LINE = $(call REPEAT,$(SPACE),$(1))$(call REPEAT,$(STAR),$(2))

# Baklava upper loop
#
# Output upper portion of Bakalava
#
# Arg 1: Starting number of spaces
# Arg 2: Starting number of stars
define UPPER_BAKLAVA_LOOP
$(info $(call BAKLAVA_LINE,$(1),$(2)))
$(if $(1),$(call UPPER_BAKLAVA_LOOP,$(call DECREMENT,$(1)),$(call ADD,$(2),$(TWO))))
endef

# Baklava lower loop
#
# Output lower portion of Baklava
# Arg 1: Starting number of spaces
# Arg 2: Starting number of stars
define LOWER_BAKLAVA_LOOP
$(if $(2),\
    $(info $(call BAKLAVA_LINE,$(1),$(2)))\
    $(call LOWER_BAKLAVA_LOOP,$(call INCREMENT,$(1)),$(call SUB,$(2),$(TWO)))\
)
endef

# Run Bakalava loops
$(call UPPER_BAKLAVA_LOOP,$(TEN),$(ONE))
$(call LOWER_BAKLAVA_LOOP,$(ONE),$(NINETEEN))

.PHONY: all
all: ;@:
