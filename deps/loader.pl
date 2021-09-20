% TODO are there any other file loading goals we need to expand???
goal_expansion(use_module(library(File)), use_module(deps/Path)) :-
  dep(File, Path).
goal_expansion(use_module(library(File), ImportList), use_module(deps/Path, ImportList)) :-
  dep(File, Path).
goal_expansion(consult(File), consult(deps/Path)) :-
  must_be(atom, File),
  dep(File, Path).
goal_expansion(consult([File|Files]), consult(ExpandedFiles)) :-
  maplist(expand_deps_path, [File|Files], ExpandedFiles).
goal_expansion([File|Files], ExpandedFiles) :-
  maplist(expand_deps_path, [File|Files], ExpandedFiles).

expand_deps_path(File, ExpandedFile) :-
  (  dep(File, Path)
  -> ExpandedFile = deps/Path
  ;  ExpandedFile = File
  ).

dep(reif, 'reif/reif').
