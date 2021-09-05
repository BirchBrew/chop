# A package manager for prolog

First, load the package manager with `[pm].`.

Then:

## Add a file as a dependency

```prolog
add_dep("https://raw.githubusercontent.com/ZakMiller/scryer-prolog/master/src/lib/freeze.pl").
```

## Download all dependencies

```prolog
sync.
```

# TODO

## Bugs
1. `syncing` only downloads files that were in your `config.pl` file when you loaded it.

## Features
1. Install dependencies of the file.