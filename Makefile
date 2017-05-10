PANDOC_FLAGS ?= -V geometry:margin=1.25in

.PHONY: all
all: book.pdf

SOURCES := \
	title.md \
	intro.md \
	shell.md

book.pdf: $(SOURCES)
	pandoc $(PANDOC_FLAGS) -o $@ $^

.PHONY: clean
clean:
	rm book.pdf
