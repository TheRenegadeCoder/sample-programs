# Constants
EMPTY :=
SPACE := $(EMPTY) $(EMPTY)
STAR := *

# Numbers are represented as x's so that they can be manipulated with text functions.
# This idea is based on how the GNU Make Standard Library (https://github.com/jgrahamc/gmsl)
# handles numbers.
ONE := x
TWO := x x
TEN := $(TWO) $(TWO) $(TWO) $(TWO) $(TWO)

# Increment function
# Arg 1: Number
# Return: Number + 1
INC = $(1) $(ONE)

# Decrement function
# Arg 1: Number
# Return: Number - 1 unless 0, else Number
DEC = $(wordlist 2,$(words $(1)),$1)

# Add function
# Arg 1: Number 1
# Arg 2: Number 2
# Return: Number 1 + Number 2
ADD = $(1) $(2)

# Subtract function
# Arg 1: Number 1
# Arg 2: Number 2
# Return: Max(Number 1 - Number 2, 0)
SUB = $(wordlist $(words $(call INC,$(2))),$(words $(1)),$(1))

# Repeat function
# Arg 1: Character
# Arg 2: Number of repeats
# Return: Character repeated specified number of times
REPEAT = $(if $(2),$(1)$(call REPEAT,$(1),$(call DEC,$(2))))

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
$(if $(1),$(call UPPER_BAKLAVA_LOOP,$(call DEC,$(1)),$(call ADD,$(2),$(TWO))))
endef

# Baklava lower loop
#
# Output lower portion of Baklava
# Arg 1: Starting number of spaces
# Arg 2: Starting number of stars
define LOWER_BAKLAVA_LOOP
$(if $(2),\
    $(info $(call BAKLAVA_LINE,$(1),$(2)))\
    $(call LOWER_BAKLAVA_LOOP,$(call INC,$(1)),$(call SUB,$(2),$(TWO)))\
)
endef

# Run Bakalava loops
$(call UPPER_BAKLAVA_LOOP,$(TEN),$(ONE))
$(call LOWER_BAKLAVA_LOOP,$(ONE),$(call DEC,$(call ADD,$(TEN),$(TEN))))

.PHONY: all
all: ;@:
