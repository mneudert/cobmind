SOURCES := $(wildcard **/*.cbl)


all: clean cobmind

cobmind:
	cobc -x $@.cbl $(SOURCES) -o $@

clean:
	rm -f cobmind
