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
# Arg 1: Number encoded as x's
# Return: Number + 1 encoded as x's
INC = $(strip $(1) $(ONE))

# Decrement function
# Arg 1: Number encoded as x's
# Return: max(Number - 1, 0) encoded as x's
DEC = $(wordlist 2,$(words $(1)),$1)

# Add function
# Arg 1: Number 1 encoded as x's
# Arg 2: Number 2 encoded as x's
# Return: Number 1 + Number 2 encoded as x's
ADD = $(strip $(1) $(2))

# Subtract function
# Arg 1: Number 1 encoded as x's
# Arg 2: Number 2 encoded as x's
# Return: Max(Number 1 - Number 2, 0) encoded as x's
SUB = $(wordlist $(words $(call INC,$(2))),$(words $(1)),$(1))

# Repeat function
# Arg 1: Character
# Arg 2: Number of repeats encoded as x's
# Return: Character repeated specified number of times
REPEAT = $(subst $(1)$(SPACE),$(1),$(foreach _,$(2),$(1)))

# Baklava line function
# Arg 1: Number of spaces encoded as x's
# Arg 2: Number of stars encoded as x's
# Return: Specified number of spaces followed by specified number of stars
BAKLAVA_LINE = $(call REPEAT,$(SPACE),$(1))$(call REPEAT,$(STAR),$(2))

# Baklava upper loop
#
# Output upper portion of Bakalava
#
# Arg 1: Starting number of spaces encoded as x's
# Arg 2: Starting number of stars encoded as x's
define UPPER_BAKLAVA_LOOP
$(info $(call BAKLAVA_LINE,$(1),$(2)))
$(if $(1),$(call UPPER_BAKLAVA_LOOP,$(call DEC,$(1)),$(call ADD,$(2),$(TWO))))
endef

# Baklava lower loop
#
# Output lower portion of Baklava
# Arg 1: Starting number of spaces encoded as x's
# Arg 2: Starting number of stars encoded as x's
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
