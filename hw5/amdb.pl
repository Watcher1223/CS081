%%
%% file: amdb.pl
%%
%% Assignment Movie Database
%%
%% Author(s): Ethan Sandoval
%%
%% CS 81 Assignment 5 Question 1

% If this file's syntax coloring is odd,
% make sure your editor is set to Prolog highlighting
% (or Plain Text), not Perl.

% some "nice" prolog settings...
:- set_prolog_flag( prompt_alternatives_on, groundness ).
:- set_prolog_flag(toplevel_print_options, [quoted(true),
     portray(true), attributes(portray), max_depth(999), priority(699)]).
:- set_prolog_flag(answer_write_options, [quoted(true),
     portray(true), attributes(portray), max_depth(999), priority(699)]).

% Below you'll find some example predicates that
% define relationships in the movie database

/*
 * Here are three example rules about the movie industry
 * Feel free to use these -- or to create new
 * helper predicates of your own...
 */

%% costar(X,Y)
%%
%% X and Y were cast in the same movie.
%
costar(X, Y) :- cast(Z, X), cast(Z, Y), X \== Y.

%% recurring(A,B)
%%
%% A and B were costars more than once.
%
recurring(A,B) :- cast(X,A), cast(X,B), cast(Y,A), cast(Y,B), X \== Y, A \== B.

%% baconpath(X,Y,Path)
%%
%% there is a path of costar pairs between X and Y.
%% Path is the list of connections between X and Y.
%
baconpath(A,B,Path) :- connected(A,B,[],P), reverse(P,Path).

connected(A,A,P,[A|P]).
connected(A,B,P,Pf) :- (cast(A,X) ; cast(X,A)), \+ member(X,P),
                 connected(X,B,[A|P],Pf).

%% shortestpath(X,Y,Path)
%%
%% find all baconpaths and return (one of) the shortest path(s).
%
shortestpath(A,B,Path) :- findall(Len-L, (baconpath(A,B,L), length(L, Len)), AllL),
                    keysort(AllL, SortedAllL), SortedAllL = [Path|_].


%% break(A, M)
%%
%% this predicate should be true if M is the movie that cast actor A with
%% the earliest release date in the database.
%
%break(A, M) :- cast(M, A), release(M, Myear), cast(Othermovies, A), release(Othermovies, Otheryear), Myear =< Otheryear.   % This is just a placeholder - replace it!
break(A, M) :- cast(M, A), release(M, Myear), \+ (cast(Othermovies, A), release(Othermovies, Otheryear), (Otheryear < Myear)).

%% releaseage(A, M, N)
%%
%% this predicate should be true if N is the age of actor A when
%% movie M was released.
%
releaseage(A, M, N) :- release(M, Year), age(A, Ageval), N is (Ageval - (2024 - Year)).   % This is just a placeholder - replace it!

%% baconnumber(A,B,N)
%%
%% this predicate should be true if N is the number of movies connecting
%% actor A and actor B for the shortest generalized bacon path.
%
baconnumber(A, B, N) :- shortestpath(A, B, Pat), Size - _ = Pat, N is (Size - 1)/2.   % This is just a placeholder - replace it!


/*
 * here are the primitive facts on which others are built...
 *
 * You may not need all of these.

 *
 * DO NOT CHANGE OR EXTEND THE FACTS BELOW!
 */

/*
 * the cast predicate
 */

cast(black_panther, freeman).
cast(black_panther, jordan).
cast(black_panther, nyongo).
cast(civil_war, evans).
cast(civil_war, freeman).
cast(civil_war, johansson).
cast(creed, jordan).
cast(creed, thompson).
cast(end_game, evans).
cast(end_game, johansson).
cast(end_game, thompson).
cast(force_awakens, driver).
cast(force_awakens, nyongo).
cast(force_awakens, pegg).
cast(marriage_story, driver).
cast(marriage_story, johansson).
cast(the_room, wiseau).

/*
 * the movie predicate
 */

movie(black_panther).
movie(civil_war).
movie(creed).
movie(end_game).
movie(force_awakens).
movie(marriage_story).
movie(the_room).

/*
 * the release predicate
 */

release(black_panther, 2018).
release(civil_war, 2016).
release(creed, 2015).
release(end_game, 2019).
release(force_awakens, 2015).
release(marriage_story, 2019).
release(the_room, 2003).

/*
 * the actor predicate
 */

actor(driver).
actor(evans).
actor(freeman).
actor(johansson).
actor(jordan).
actor(nyongo).
actor(pegg).
actor(thompson).
actor(wiseau).

/*
 * the age predicate
 */

age(driver, 40).
age(evans, 42).
age(freeman, 52).
age(johansson, 39).
age(jordan, 36).
age(nyongo, 40).
age(pegg, 53).
age(thompson, 40).
age(wiseau, 68).
