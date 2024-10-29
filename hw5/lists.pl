%% lists.pl
%%
%% Author(s): Ethan Sandoval
%%
%% CS 81 HW 5, Problem 2

% If this file's syntax coloring is odd,
% make sure your editor is set to Prolog highlighting
% (or Plain Text), not Perl.

% some "nice" prolog settings...
:- set_prolog_flag( prompt_alternatives_on, groundness ).
:- set_prolog_flag(toplevel_print_options, [quoted(true),
     portray(true), attributes(portray), max_depth(999), priority(699)]).
:- set_prolog_flag(answer_write_options, [quoted(true),
     portray(true), attributes(portray), max_depth(999), priority(699)]).


%%%%%%%%%%
% PART A %
%%%%%%%%%%

%%% Give one or more rules defining the removeOne predicate.
%%% (and any helper predicates, if needed)
removeOne(E, [E|R], NewList):- NewList = R.
removeOne(E, [First | Rest], [First|R]):- removeOne(E, Rest, R).

%%%%%%%%%%
% PART B %
%%%%%%%%%%

%%% Give one or more rules defining the find predicate.
%%% (and any helper predicates, if needed)

%find(Pattern, Target, Index):- \+(length(Pattern, 0)), .
find([PF], [PF|_], 0).

find([PF|PR], [PF|TR], 0):- find(PR, TR, 0).

find(Pattern, [_|TR], Index):- find(Pattern, TR, NewIndex), Index is NewIndex + 1.