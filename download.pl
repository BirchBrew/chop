:- module(download, [down/2]).

:- use_module(library(http/http_open)).
:- set_prolog_flag(double_quotes, chars).
:- use_module(library(filesex)).
:- use_module(library(archive)).

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

download_url_to_deps_directory(URL) :-
  setup_call_cleanup(
    http_open(URL, In, []),
    setup_call_cleanup(
      tmp_file_stream(binary, File, Out),
      copy_stream_data(In, Out),
    close(Out)
    ),
  close(In)
  ),
  archive_extract(File, deps, []),
  delete_file(File).