SOURCES := $(wildcard **/*.cbl)
OBJECTS := $(SOURCES:.cbl=.o)


%.o: %.cbl
	cobc -c $< -o _build/$(notdir $@)


all: clean prepare cobmind


clean:
	rm -rf _build
	rm -f cobmind

cobmind: $(OBJECTS)
	cobc -x $@.cbl _build/*.o -o $@

prepare:
	mkdir _build
