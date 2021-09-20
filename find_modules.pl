:- module(find_modules, [find_deps/2]).

stream_line(In, Line) :-
    repeat,
    (   read_line_to_string(In, Line0),
        Line0 \== end_of_file
    ->  Line0 = Line
    ;   !,
        fail
    ).

read_with_backtracking(In, Term) :-
                    repeat,
                    catch(read(In, ReadTerm), error(syntax_error(_), _), fail),
                    (  ReadTerm \= end_of_file
                    -> ReadTerm = Term
                    ;  !,
                       fail
                    ).
find_deps(Path, Modules)
                    :-   open(Path, read, Handle),
                    findall((X, Y), read_with_backtracking(Handle, :- module(X, Y)), Modules),
                    writeln(Modules),
                    close(Handle).
