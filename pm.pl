:- use_module(download).
:- use_module(config).

download_to_disk(URL, Version) :- 
    split_string(URL, "/", "", Pieces),
    last(Pieces, PackageName),
    format(atom(Formatted), 'deps/~w', [PackageName]),
    down(URL, Formatted).   

sync :- forall(dependency(URL, Version), download_to_disk(URL, Version)).

add_dep(URL, Version) :- open('config.pl', append, Handle), 
                     format(atom(Formatted), 'dependency("~w", "~w").', [URL, Version]),
                     writeln(Handle, Formatted), 
                     close(Handle).
  
add_dep(URL) :- open('config.pl', append, Handle), 
            format(atom(Formatted), 'dependency("~w", "latest").', [URL]),
            writeln(Handle, Formatted), 
            close(Handle).
   
