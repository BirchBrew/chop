:- module(find_modules, [find_deps/1]).

file_line(File, Line) :-
    setup_call_cleanup(open(File, read, In),
        stream_line(In, Line),
        close(In)).

stream_line(In, Line) :-
    repeat,
    (   read_line_to_string(In, Line0),
        Line0 \== end_of_file
    ->  Line0 = Line
    ;   !,
        fail
    ).

process(:- module(X, _)) :- write_canonical(X),nl.

find_deps(Path) :-   open(Path, read, Handle),
                    repeat,
                    read(Handle, Term),
                    (  Term == end_of_file
                    -> !
                    ;  process(Term),
                    fail
                    ),
                    close(Handle).

% find_deps(Path) :- file_line(Path, Line),
%                     process(Line).