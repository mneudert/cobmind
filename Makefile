all: clean cobmind

cobmind:
	cobc -x cobmind.cbl

clean:
	rm -f cobmind
