:- use_module(download).
:- use_module(config).

download_to_disk(URL, Version) :- 
    split_string(URL, "/", "", Pieces),
    last(Pieces, PackageName),
    format(atom(Formatted), 'deps/~w', [PackageName]),
    down(URL, Formatted).   

:- forall(dependency(URL, Version), download_to_disk(URL, Version)).
  
   
