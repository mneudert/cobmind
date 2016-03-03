SOURCES := $(wildcard **/*.cbl)
OBJECTS := $(SOURCES:.cbl=.o)

CBL_OBJECTS := $(filter-out test%,$(OBJECTS))
TST_SOURCES := $(wildcard test/**/*.cbl)

# empty line necessary for simple loop calls
define TEST_TEMPLATE
	cobc $(CFLAGS) $(CBLFLAGS) $(LDFLAGS) -x $(1) -o _build/*.o -o _test/$(notdir $(basename $(1)))
	_test/$(notdir $(basename $(1)))
	rm _test/$(notdir $(basename $(1)))

endef


%.o: %.cbl
	cobc $(CFLAGS) $(CBLFLAGS) $(LDFLAGS) -c $< -o _build/$(notdir $@)


all: clean_build clean_exec prepare_build cobmind

clean: clean_build clean_test clean_exec

clean_build:
	rm -rf _build

clean_exec:
	rm -f cobmind

clean_test:
	rm -rf _test

cobmind: $(CBL_OBJECTS)
	cobc $(CFLAGS) $(CBLFLAGS) $(LDFLAGS) -x $@.cbl _build/*.o -o $@

prepare_build:
	mkdir _build

prepare_test:
	mkdir _test

test: clean_build clean_test prepare_build prepare_test $(CBL_OBJECTS)
	$(foreach TST_SOURCE, $(TST_SOURCES), $(call TEST_TEMPLATE,$(TST_SOURCE)))
