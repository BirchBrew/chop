:- use_module(download).
:- use_module(config).

download_to_disk(URL, Version) :- format(atom(Formatted), 'deps/~w', [Version]),
down(URL, Formatted).   

:- forall(dependency(URL, Version), download_to_disk(URL, Version)).
  
   
