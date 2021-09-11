:- use_module(download).
:- use_module(config).

create_dir_if_needed :- \+ exists_directory("deps"),
     make_directory("deps").
     
download_to_disk(URL, Version) :- 
    split_string(URL, "/", "", Pieces),
    last(Pieces, PackageName),
    format(atom(Formatted), 'deps/~w', [PackageName]),
    down(URL, Formatted).   

sync :- create_dir_if_needed,
        forall(dependency(URL, Version), download_to_disk(URL, Version)).

url_found(URL) :- dependency(URL, _).
write_needed(URL) :- \+ url_found(URL).
write_dep(URL) :- open('config.pl', append, Handle),
                  download_to_disk(URL, _),
                  format(atom(Formatted), 'dependency("~w", "latest").', [URL]),
                  writeln(Handle, Formatted),
                  print("Dependency added"),
                  close(Handle),
                  make.

  
add_dep(URL) :- ( write_needed(URL) -> write_dep(URL) ; print("Nothing to do") ).
