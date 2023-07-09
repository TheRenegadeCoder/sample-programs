define TEXT
Hello from GNU Make
Here are some lines:
This is line 1
This is line 2
Goodbye!
endef

$(file >output.txt,$(TEXT))
$(info $(file <output.txt))

.PHONY: all
all: ;@:
