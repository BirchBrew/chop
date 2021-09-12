:- use_module(library(optparse)).
:- set_prolog_flag(double_quotes, chars).

% when running the standalone saved state on Windows (chop.exe), the first argv is
% something like C:\projects\chop\chop.exe, so we want to filter that out
:- if(current_prolog_flag(windows, true)).
  term_expansion(
    main(Argv) :- Body,
    main(RawArgv) :- (filter_argv(RawArgv, Argv), Body)
  ).

  filter_argv([], []).
  filter_argv([First|Rest], Argv) :-
    (  current_prolog_flag(saved_program, true)
    -> Argv = Rest
    ;  Argv = [First|Rest]
    ).
:- endif.

:- initialization(main, main).

main(Argv) :-
  writeln(Argv).
