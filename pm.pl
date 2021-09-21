:- use_module(download).
:- use_module(config).
:- use_module(find_modules).
:- use_module(logger).

     
create_dir_if_needed :-  
    (  exists_directory(deps)
        -> true
        ;  make_directory(deps)
    ).
     
download_dependency_to_disk(URL, Version, PackageName) :- 
    create_dir_if_needed,
    split_string(URL, "/", "", Pieces),
    last(Pieces, PackageName),
    format(atom(Formatted), 'deps/~w', [PackageName]),
    verbose_log("Downloading to disk."),
    down(URL, Formatted).   

sync :- 
    create_dir_if_needed,
    forall(dependency(URL, Version), download_dependency_to_disk(URL, Version, _)).

write_source(Handle, Module, File) :-
    write_term(Handle, source(Module, File), [quoted(true), fullstop(true), nl(true)]).

update_sources_list(File) :-
    format(atom(Formatted), 'deps/~w', [File]),
    (\+ find_deps(Formatted, [(ModuleName, _)])
    -> verbose_log("No module declarations in file. Deleting from disk."),
    delete_file(Formatted),
    false
    ; find_deps(Formatted, [(ModuleName, _)]),
      verbose_log("Found a module"),
      verbose_log(ModuleName),
    setup_call_cleanup(
        open('deps/sources.pl', append, Handle),
        write_source(Handle, ModuleName, File),
        close(Handle))
).
   

url_found(URL) :- dependency(URL, _).
write_dependency_to_config(Handle, URL) :- 
    setup_call_cleanup(
        open('config.pl', append, Handle),
        write_term(Handle, dependency(URL, "latest"), [quoted(true), fullstop(true), nl(true)]),
        close(Handle)
    ).
    
       
write_needed(URL) :- \+ url_found(URL),
                      verbose_log("New package"),
                      nl.
write_dep(URL) :- 
    download_dependency_to_disk(URL, _, PackageName),
    update_sources_list(PackageName),
    write_dependency_to_config(Handle, URL),
    verbose_log("Dependency added"),
    make.

  
add_dep(URL) :- 
    ( write_needed(URL) -> write_dep(URL) ; verbose_log("Nothing to do") ).
