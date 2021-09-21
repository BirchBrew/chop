:- module(log, [verbose_log/1]).

% https://www.swi-prolog.org/pldoc/doc_for?object=current_prolog_flag/2 (look up verbose)
% https://www.swi-prolog.org/pldoc/man?predicate=print_message/2
verbose_log(Message) :- 
                print_message(informational, Message).