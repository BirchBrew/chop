:- use_module(download).
:- use_module(config).

:- dependency(URL, Version),
   format(atom(Formatted), 'deps/~w', [Version]),
   down(URL, Formatted).
   
