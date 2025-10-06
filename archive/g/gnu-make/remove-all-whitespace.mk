USAGE := Usage: please provide a string

# Constants
EMPTY :=
SPACE := $(EMPTY) $(EMPTY)

# Note that this is non-portable, but it's the only way I could get a carriage return
# assigned to a variable
CR := $(shell printf '\r')

# Remove all whitespace
#
# Note that GNU Make automatically converts tab and newline ('\n') to a space and
# that leading and trailing whitespace are ignore, so all that needs to be done
# is to remove carriage return (`\r') and space.
#
# Arg 1: The string
# Return: The string without whitespace
REMOVE_ALL_WHITESPACE = $(subst $(CR),,$(subst $(SPACE),,$(1)))

# If string not provided, display usage statement
# Else display string without whitespace
ifeq (,$(ARGV1))
$(info $(USAGE))
else
NUMBER := $(call CONVERT_NUMBER,$(strip $(ARGV1)))
$(info $(call REMOVE_ALL_WHITESPACE,$(ARGV1)))
endif

.PHONY:
all: ;@:
