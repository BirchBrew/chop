:- module(download, [down/2]).

:- use_module(library(http/http_open)).
:- set_prolog_flag(double_quotes, chars).

down(URL, LocalFile) :-
    setup_call_cleanup(
      http_open(URL, In, []),
      setup_call_cleanup(
        open(LocalFile, write, Out),
        copy_stream_data(In, Out),
        close(Out)
        ),
      close(In)
    ).