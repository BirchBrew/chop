:- module(find_modules, [find_deps/2]).
:- use_module(logger).

read_with_backtracking(In, Term) :-
    repeat,
    read(In, ReadTerm),
    (  ReadTerm \= end_of_file
    -> ReadTerm = Term
    ;  !,
       fail
    ).
find_module_declaration(Handle, [(ModuleName, ModuleVersion)]) :-
    read_with_backtracking(Handle, :- module(ModuleName, ModuleVersion)),
    verbose_log("Found module").

find_deps(Path, Modules) :-
    setup_call_cleanup(
        open(Path, read, Handle),
        find_module_declaration(Handle, Modules),
        close(Handle)
    ).