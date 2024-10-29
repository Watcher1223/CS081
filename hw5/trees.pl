%% trees.pl
%%
%% Author(s): Ethan Sandoval
%%
%% CS 81 HW 5, Problem 3

% If this file's syntax coloring is odd,
% make sure your editor is set to Prolog highlighting
% (or Plain Text), not Perl.

% some "nice" prolog settings...
:- set_prolog_flag( prompt_alternatives_on, groundness ).
:- set_prolog_flag(toplevel_print_options, [quoted(true),
     portray(true), attributes(portray), max_depth(999), priority(699)]).
:- set_prolog_flag(answer_write_options, [quoted(true),
     portray(true), attributes(portray), max_depth(999), priority(699)]).

% Finish the following four definitions,
% and add any other helper predicates you require

%%%%%%%%%%
% PART A %
%%%%%%%%%%

% We did the base case for you; an input
%   evaluates to itself if that input is a number.
% You just need to do all the other cases.

eval(X, X) :- number(X).

eval([+, Left, Right], N) :- eval(Left, Lval), eval(Right, Rval), N is Lval + Rval.

eval([-, Left, Right], N) :- eval(Left, Lval), eval(Right, Rval), N is Lval - Rval.

eval([*, Left, Right], N) :- eval(Left, Lval), eval(Right, Rval), N is Lval * Rval.

eval([/, Left, Right], N) :- eval(Left, Lval), eval(Right, Rval), Rval \= 0, N is Lval // Rval.

%%%%%%%%%%
% PART B %
%%%%%%%%%%

atree(Ops, [L], L).

%atree(Ops, [Lop|Lrest], [Top, Ltree, Rtree]):- \+(length(Lrest, 0)), member(Top, Ops), atree(Ops, ).
atree(Ops, L, [Top, Ltree, Rtree]):- member(Top, Ops), append(L1, L2, L), L1 \= [], L2 \= [], atree(Ops, L1, Ltree), atree(Ops, L2, Rtree).

%%%%%%%%%%
% PART C %
%%%%%%%%%%

solve(Ops, L, X, Tree):- permutation(Perms, L), atree(Ops, Perms, Tree), eval(Tree, X).  % Placeholder: replace with your rule.

% Hint: recall that
%   permutation(L,M) is true if list L is a permutation of list M.
% (This is the only definition in the entire assignment
%  where permutations are useful!)
