:- module(download, [down/2]).

:- use_module(library(http/http_open)).
:- set_prolog_flag(double_quotes, chars).
:- use_module(library(clpfd)).

loop_through_list(File, List) :-
    member(Element, List),
    write(File, Element),
    fail.

write_list_to_file(Filename,List) :-
    open(Filename, write, File),
    \+ loop_through_list(File, List),
    close(File).

down(X, F) :- http_open(X, In, []),
read_stream_to_codes(In, Codes),
maplist(char_code, Chars, Codes),
write_list_to_file(F, Chars),
close(In).