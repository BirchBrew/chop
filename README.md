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

# Development notes
to build a standalone binary (Unix) or executable (Windows)
```sh
$ swipl --stand_alone=true -o chop -c chop.pl
```
or more conveniently to do that exact same thing, use the Makefile
```sh
$ make
```
for Windows, the `.exe` file will still depend on a handfull of `.dll` files which can be found in `C:\Program Files\swipl\bin`. These are the required ones, which must be installed in the same directory as the executable or in a directory available through `%PATH%`:
- libgcc_s_seh-1.dll
- libgmp-10.dll
- libswipl.dll
- libwinpthread-1.dll
- zlib1.dll

see [the SWI-Prolog docs](https://www.swi-prolog.org/FAQ/WinExe.html), though they're unfortunately a bit outdated here. I've opened [a PR to update them](https://github.com/SWI-Prolog/plweb-www/pull/45).

# TODO

## Bugs
1. Nested folders for dependency?
2. Download whole repo?
3. Validate that we're dealing with prolog.

## Features
1. Install dependencies of the file.
