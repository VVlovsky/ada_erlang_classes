%%%-------------------------------------------------------------------
%%% @author Vyacheslav Trushkov
%%% @copyright (C) 2020, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 29. Oct 2020 2:22 PM
%%%-------------------------------------------------------------------
-module(lab4).
-import(math, [sqrt/1, pi/0]).
-author("Vyacheslav Trushkov").


%% API
-export([pole/1, amin/1, amin_compare/2, amax/1, amax_compare/2, tmin_max/1, tmin_max_compare/2, nlist/1, nlist/2,
  split/1, split/2, split1/2, split2/2, reverse/1, reverse/2, merge/2, merge_step/3, insert/2, append/1, append/2]).

pole({kwadrat, X, Y}) -> X * Y;
pole({stozek, R, L}) -> math:pi() * R * (R + L); %%Pi*R(R+L)
pole({kolo, X}) -> math:pi() * X * X.


amin([]) -> 0;
amin([H | T]) ->  %%wywoluje funkcjcę pomocniczą
  amin_compare(T, H).

amin_compare([], E) -> E;
amin_compare([H | T], E) when E < H -> amin_compare(T, E); % wyrzucamy head bo jest większy
amin_compare([H | T], E) when H < E -> amin_compare(T, H). % zapisujemy head

amax([]) -> 0;
amax([H | T]) ->
  amax_compare(T, H).

amax_compare([], E) -> E;  % to samo co wyżej
amax_compare([H | T], E) when E > H -> amax_compare(T, E);
amax_compare([H | T], E) when H > E -> amax_compare(T, H).

tmin_max([]) -> 0;
tmin_max([H | T]) ->
  tmin_max_compare(T, {H, H}).  %to samo co wyżej, lecz są wymienione wszystkie możliwe kombincję

tmin_max_compare([], {EL, EH}) -> {EL, EH};
tmin_max_compare([H | T], {EL, EH}) when (EL < H) and (EH > H) -> tmin_max_compare(T, {EL, EH});
tmin_max_compare([H | T], {EL, EH}) when (EL > H) and (EH > H) -> tmin_max_compare(T, {H, EH});
tmin_max_compare([H | T], {EL, EH}) when (EL < H) and (EH < H) -> tmin_max_compare(T, {EL, H});
tmin_max_compare([H | T], {EL, EH}) when (EL > H) and (EH < H) -> tmin_max_compare(T, {H, H}). % chyba nigdy się nie wypelni

nlist(N) -> nlist(N, []).
nlist(0, L) -> L;
nlist(N, L) -> nlist(N - 1, L ++ [N]). % dodajemy N i wywolujemy rekurencyjnie z N-1


% Tu mam 2 funkcje gdzie 1a wywoluje 2gą a 2ga wywołuje 1ą.
% Funkcja 1 dodaje do head pierwszej listy, funkcja 2 dodaje do head drugiej
split(L) -> split(L, [[], []]).
split([], [L1, L2]) -> [L1, L2];
split(L, [L1, L2]) -> split1(L, [L1, L2]).
split1([], [L1, L2]) -> [L1, L2];
split1([H | T], [L1, L2]) -> split2(T, [[H | L1], L2]).
split2([], [L1, L2]) -> [L1, L2];
split2([H | T], [L1, L2]) -> split1(T, [L1, [H | L2]]).

% Przepisujemy listę w odwrotnej kolejności
reverse(L) -> reverse(L, []).
reverse([], R) -> R;
reverse([H | T], R) -> reverse(T, [H | R]).

% Po kolei sprawdzamy elementy i wstawiamy head pierwszej lub drugiej listy
merge(L1, L2) -> merge_step(L1, L2, []).
merge_step([], L2, R) -> R ++ L2; % Na koniec dodajemy pozostałe elementy
merge_step(L1, [], R) -> R ++ L1;
merge_step([H|T], [H2|T2], R) when (H < H2) -> merge_step(T, [H2|T2], R ++ [H]);
merge_step([H|T], [H2|T2], R) when (H > H2) -> merge_step([H|T], T2, R ++ [H2]).

% Wstawiamy element aż będzie mniejszy od head
insert(X,[]) -> [X];
insert(X,L=[H|_]) when X =< H -> [X|L];
insert(X,[H|T]) -> [H|insert(X, T)].

% Lączymy każdy element z acc po kolei, na początku acc = []
append(List) -> append(List,[]).
append([], Acc) -> Acc;
append([H|T],Acc) -> append(T, H ++ Acc).