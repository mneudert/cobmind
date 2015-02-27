all: cobmind

cobmind:
	cobc -x cobmind.cbl

clean:
	rm cobmind
