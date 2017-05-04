# CobMind

MaxMind GeoIP2 database reader/decoder in COBOL.


## Warning

This is (for now) only an experiment. It may or may not reach a usable state.
Except if you are helping ;)


## Setup

```shell
make
./cobmind
```


## Usage

Combind expects both the used database and the IP to lookup
as command line parameters:

```shell
./cobmind -d ./test-data/CobMind.mmdb -i 127.0.0.1
./cobmind --database ./test-data/CobMind.mmdb --ip 127.0.0.1
```

If either of the parameters are missing the program will exit
with an appropriate message.


## Testing

```shell
make test
```


## Teardown

```shell
make clean
```
