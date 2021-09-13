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

sync :- 
    create_dir_if_needed,
    forall(dependency(URL, Version), download_to_disk(URL, Version, _)).

write_source(Handle, Module, File) :-
    format(atom(SourceLine), 'source("~w", "~w").', [Module, File]),
    writeln(Handle, SourceLine).
handle_module_sources(File) :-
    format(atom(Formatted), 'deps/~w', [File]),
    find_deps(Formatted, [(Module, _)]),
    setup_call_cleanup(
    open('deps/sources.pl', append, Handle),
    write_source(Handle, Module, File),
    close(Handle)).

url_found(URL) :- dependency(URL, _).
probably_add_dep(Handle, URL) :- 
    format(atom(Formatted), 'dependency("~w", "latest").', [URL]),
    writeln(Handle, Formatted).
       
write_needed(URL) :- \+ url_found(URL).
write_dep(URL) :- 
    setup_call_cleanup(
        open('config.pl', append, Handle),
        probably_add_dep(Handle, URL),
        close(Handle)),
    download_to_disk(URL, _, PackageName),
    
    print("Dependency added"),
    print(PackageName),
    handle_module_sources(PackageName),
    make.

  
add_dep(URL) :- 
    ( write_needed(URL) -> write_dep(URL) ; print("Nothing to do") ).
