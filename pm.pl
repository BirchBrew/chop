:- use_module(download).
:- use_module(config).
:- use_module(find_modules).
create_dir_if_needed :- \+ exists_directory("deps"),
     make_directory("deps").
     
download_to_disk(URL, Version, PackageName) :- 
    split_string(URL, "/", "", Pieces),
    last(Pieces, PackageName),
    format(atom(Formatted), 'deps/~w', [PackageName]),
    down(URL, Formatted).   

sync :- create_dir_if_needed,
        forall(dependency(URL, Version), download_to_disk(URL, Version, _)).

handle_module_sources(File) :-
                               format(atom(Formatted), 'deps/~w', [File]),
                               find_deps(Formatted, [(Module, _)]),
                               open('deps/sources.pl', append, Handle),
                               format(atom(SourceLine), 'source("~w", "~w").', [Module, File]),
                               writeln(Handle, SourceLine),
                               close(Handle).

url_found(URL) :- dependency(URL, _).
write_needed(URL) :- \+ url_found(URL).
write_dep(URL) :- open('config.pl', append, Handle),
                  download_to_disk(URL, _, X),
                  format(atom(Formatted), 'dependency("~w", "latest").', [URL]),
                  writeln(Handle, Formatted),
                  print("Dependency added"),
                  print(X),
                  handle_module_sources(X),
                  close(Handle),
                  make.

  
add_dep(URL) :- ( write_needed(URL) -> write_dep(URL) ; print("Nothing to do") ).
