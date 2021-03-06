# Zork-Racket

I'm implementing a [Zork I](https://en.wikipedia.org/wiki/Zork_I)-like game to learn [Racket](https://racket-lang.org/). It is nowhere near complete. Or stable. It seems to work on latest (v8.0 [cs]).

## Run

```sh
./zork
```

## Tests

All:
```sh
./test
```

Single file:
```sh
./test src/state.test.rkt
```

Watch for changes in the current directory with [inotify-hookable](https://packages.debian.org/buster/inotify-hookable):
```sh
inotify-hookable -q -f . -c 'clear && ./test'
```
