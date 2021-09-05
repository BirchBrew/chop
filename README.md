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
2. Adding a dependency should download it and shouldn't add it to your config if it can't be found.
3. Nested folders for dependency?
4. Download whole repo?
5. Validate that we're dealing with prolog.

## Features
1. Install dependencies of the file.